import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:chomp_migration/pages/game_modes.dart';
import 'package:chomp_migration/components/dot_loader.dart';
import 'package:chomp_migration/components/grid_view_maker.dart';
import 'package:chomp_migration/components/timer.dart';
import 'package:chomp_migration/components/my_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(GameMainPageOnline());
}

class GameMainPageOnline extends StatefulWidget {
  static const String tag = 'game-main-page-online';

  @override
  _GameMainPageOnlineState createState() => _GameMainPageOnlineState();
}

class _GameMainPageOnlineState extends State<GameMainPageOnline> {
  int initCounter = 0;
  double borderWidth = 3;
  SocketIO socket;
  SocketIOManager manager;
  int _start = 0;
  String serverAddress = 'http://chompu.herokuapp.com/';

  double bigIcon = 100;
  double littleIcon = 50;

  Timer _timer;
  var outputData = {'nums': nums, 'id': id};
  int opponentIndex;
  bool connected = false;

  String opponentName = '';
  String roomName = '';

  final player = AudioCache();

  @override
  void initState() {
    _initSocket();
    initCounter++;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPopScope(context),
      child: Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (context) => Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.face,
                                size: turn ? bigIcon : littleIcon,
                                color: turn
                                    ? Theme.of(context).primaryColorDark
                                    : Theme.of(context).accentColor,
                              ),
                              Text('$id')
                            ],
                          ),
                        ),
                        Container(
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.language,
                                size: turn ? littleIcon : bigIcon,
                                color: turn
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColorDark,
                              ),
                              Text('$opponentName')
                            ],
                          ),
                        )
                      ],
                    ),
                    gridViewMaker(context),
                    SizedBox(
                      height: 30,
                    ),
                    connected
                        ? Container()
                        : ColorLoader4(
                            duration: Duration(milliseconds: 1200),
                            dotType: DotType.square,
                            dotOneColor: Theme.of(context).accentColor,
                            dotTwoColor:
                                Theme.of(context).accentColor.withOpacity(0.6),
                            dotThreeColor:
                                Theme.of(context).accentColor.withOpacity(0.3),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    connected ? Container() : Text('Finding Opponent...'),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Widget gridViewMaker(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      alignment: Alignment.center,
      child: GridViewMaker(
        func: gridViewMakerFunction,
      ),
    );
  }

  _initSocket() async {
    manager = SocketIOManager();
    socket = await manager.createInstance(serverAddress, enableLogging: true);
    socket.onConnect((data) {
      print("connected...");
      socket.emit('init', [outputData]);
    });

    socket.on('wait', (data) {
      print('wait: ${data.toString()}');
    });

    socket.on('start', (data) {
      print('start: ${data.toString()}');
      setState(() {
        print(data['your_turn']);
        print(data['nums']);
        resetGame();
        nums = data['nums'];
        print(data['another_player']['id']);
        opponentName = data['another_player']['id'];
        print(data['room_name']);
        roomName = data['room_name'];
        initBoardWithOppMoves();
        connected = true;
        turn = data['your_turn'];
        turn = getTurn();
      });
    });

    socket.on('data', (data) {
      print('data: ${data.toString()}');
      print('data: ${data.runtimeType}');
      print('data.num: ${data['num']}');
      setState(() {
        popChompItem(data['num']);
        player.play(
          'audios/alert.mp3',
        );
      });

      if (gameOver) gameOverDialog(context, 'online');
    });

    socket.on('end', (data) {
      switch (data['code']) {
        case 0:
          if (data['loser'] == id)
            gameAlertDialog(context, 'game_over_loose');
          else {
            setState(() {
              popChompItem(0);
            });
            gameAlertDialog(context, 'game_over_win');
          }
          break;
        case 1:
          gameAlertDialog(context, 'opponent_left');
          break;
      }
    });

    socket.on('pause', (data) {
      showDialog(
          context: context,
          builder: (_) {
            return MyDialog();
          });
    });

    socket.on('in_game', (data) {
      Navigator.of(context).pop();
      // another player back to game.i
      // if you are lefter player this means you are in a room and game stared before left the game.
      // data of 'in_game' = data of 'start'
    });

    socket.on('err', (data) {
      /*
      {
       id: {
          code: 1,
          msg: 'send another id'
       },
       turn: {
          code: 2,
          msg: 'not your turn'
       },
       wait: {
          code: 3,
          msg: 'please wait'
       },
       init: {
          code: 4,
          msg: 'you should initialize first'
       },
       empty_id: {
          code: 5,
          msg: 'please send id'
       },
       disable_game: {
          code: 6,
          msg: 'your opponent is disconnected yet'
       },
       null_data: {
          code: 7,
          msg: 'your data event has null data. send correct json with board or num attr.'
       }
      }
       */
      print('err: $data');
      manager.clearInstance(socket);
    });
    socket.onError((errorData) {
      print('errorData: $errorData');
      manager.clearInstance(socket);
    });

    socket.connect();
  }

  Future<void> gameAlertDialog(BuildContext context, String type) {
    Widget content;
    String title;
    switch (type) {
      case 'game_over_loose':
        title = 'GAME OVER';
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.skull,
              color: Colors.black,
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text('You Lost'),
          ],
        );
        break;
      case 'game_over_win':
        title = 'GAME OVER';
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.trophy,
              color: Colors.yellow[900],
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text('You Won')
          ],
        );
        break;
      case 'opponent_left':
        title = 'GAME OVER';
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.directions_run,
              color: Colors.yellow[900],
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text('You Won'),
          ],
        );
        break;
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(title),
            ),
            content: content,
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(GameStartPage.tag));
                  resetGame();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
//        ??
//        false; //.then(onValue);
  }

  gridViewMakerFunction(BuildContext context, int index) {
    print('before if');
    if (connected) {
      if (turn) {
        setState(() {
        popChompItem(index);
        player.play(
          'audios/eating.mp3',
        );
        });
        socket.emit('data', [
          {'num': index}
        ]);
        if (gameOver) gameOverDialog(context, 'online');
      }
    }
  }

  @override
  void dispose() {
    socket.emit('cancel', null);
    manager.clearInstance(socket);
    super.dispose();
  }
}