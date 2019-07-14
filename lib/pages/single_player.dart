import 'package:audioplayers/audio_cache.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:chomp_migration/components/grid_view_maker.dart';
import 'package:chomp_migration/components/my_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(GameMainPage());
}

class GameMainPage extends StatefulWidget {
  static const String tag = 'game-main-page';

  @override
  _GameMainPageState createState() => _GameMainPageState();
}

class _GameMainPageState extends State<GameMainPage> {
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
                    buildAvatars(context),
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

  Widget buildAvatars(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          Icons.face,
          size: turn ? bigIcon : littleIcon,
          color: turn
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).accentColor,
        ),
        Icon(
          Icons.smartphone,
          size: turn ? littleIcon : bigIcon,
          color: turn
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColorDark,
        ),
      ],
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
    if (turn) {
      setState(() {
        popChompItem(index);
        player.play(
          'audios/eating.mp3',
        );
      });
      SystemSound.play(SystemSoundType.click);
      if (gameOver) {
        Future.delayed(
            const Duration(
              milliseconds: 500,
            ),
            () => gameOverDialog(context, 'single'));
      } else
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            popChompItem(AI());
            player.play(
              'audios/alert.mp3',
            );
          });
        }).then((value) {
          if (gameOver) {
            Future.delayed(
                const Duration(
                  milliseconds: 500,
                ),
                () => gameOverDialog(context, 'single'));
          }
        });
    }
  }
}