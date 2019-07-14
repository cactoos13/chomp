import 'package:audioplayers/audio_cache.dart';
import 'package:chomp_migration/pages/multi_player.dart';
import 'package:chomp_migration/ScreenArguments.dart';
import 'package:chomp_migration/pages/single_player.dart';
import 'package:chomp_migration/pages/online_game.dart';
import 'package:chomp_migration/components/grid_view_maker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:chomp_migration/game_logic.dart';

class GameSetBoardPage extends StatefulWidget {
  static String tag = 'game-set-board-page';

  @override
  _GameSetBoardPageState createState() => _GameSetBoardPageState();
}

class _GameSetBoardPageState extends State<GameSetBoardPage> {
  double borderWidth = 3;
  double bigIcon = 100;
  double littleIcon = 50;
  IconData icon1;
  IconData icon2;
  bool isMulti;
  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    isMulti = args.message == GameMainPageMultiPlayer.tag;

    switch (args.message) {
      case GameMainPage.tag:
        icon1 = Icons.face;
        icon2 = Icons.smartphone;
        break;
      case GameMainPageOnline.tag:
        icon1 = Icons.face;
        icon2 = Icons.language;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Board Game',
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(2),
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.play_arrow,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            onPressed: () {
              print(args.message);
              Navigator.of(context).pushNamed(args.message);
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.shuffle,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  setState(() {
                    shuffle();
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Icon(
                  Icons.replay,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  setState(() {
                    resetGame();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            buildAvatars(context),
            gridViewMaker(context),
          ],
        ),
      ),
//      ),
    );
  }

  Widget gridViewMaker(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        alignment: Alignment.center,
        child: GridViewMaker(
          func: itemFunction,
        ));
  }

  Widget buildAvatars(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: isMulti
            ? <Widget>[
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: turn ? bigIcon : littleIcon,
                    color: turn
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).accentColor,
                  ),
                ),
                Text(
                  '2',
                  style: TextStyle(
                    fontSize: turn ? littleIcon : bigIcon,
                    color: turn
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
              ]
            : <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    icon1,
                    size: turn ? bigIcon : littleIcon,
                    color: turn
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).accentColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    icon2,
                    size: turn ? littleIcon : bigIcon,
                    color: turn
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
              ]);
  }
}

void itemFunction(BuildContext context, int index) {
  if (index == 0) {
    showSnackBar(context);
  } else {
    popChompItem(index);
    nums.add(index);
    turn = !turn;
  }
}

void showSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: Text("You can't play with an empty board!"),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

class GridViewClass extends StatelessWidget {
//  const GridViewClass({Key key,}) : super(key: key);
  final double borderWidth;
  final Function onPress;

  GridViewClass({this.borderWidth, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      alignment: Alignment.center,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 10,
        shrinkWrap: true,
        children: List.generate(100, (index) {
          return GestureDetector(
            onTap: onPress,
            child: secondVector[index] == 0
                ? Container()
                : Container(
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.all(5),
                    child: Container(
                      color: Theme.of(context).accentColor,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: borderWidth),
                            left: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: borderWidth),
                            right: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: borderWidth),
                            bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: borderWidth),
                          ),
                        ),
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: Text(
                          '$index',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}