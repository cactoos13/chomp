import 'package:audioplayers/audio_cache.dart';
import 'package:chomp_migration/components/grid_view_maker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:chomp_migration/components/my_dialogs.dart';

void main() {
  runApp(GameMainPageMultiPlayer());
}

class GameMainPageMultiPlayer extends StatefulWidget {
  static const String tag = 'game-main-page-multi-player';

  @override
  _GameMainPageMultiPlayerState createState() =>
      _GameMainPageMultiPlayerState();
}

class _GameMainPageMultiPlayerState extends State<GameMainPageMultiPlayer> {
//  double borderWidth = 2;
  double borderWidth = 3;
  double bigIcon = 100;
  double littleIcon = 50;
  final player = AudioCache();

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
                      ],
                    ),
                    gridViewMaker(context),
                    SizedBox(
                      height: 50,
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
      padding: EdgeInsets.only(top: 25),
      alignment: Alignment.center,
      child: GridViewMaker(
        func: gridViewMakerFunction,
      ),
    );
  }

  void gridViewMakerFunction(BuildContext context, int index) {
    setState(() {
      popChompItem(index);
      player.play(
        'audios/eating.mp3',
      );
    });
    if (gameOver)
      Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
          () => gameOverDialog(context, 'multi'));
  }
}