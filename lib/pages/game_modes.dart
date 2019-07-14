import 'package:chomp_migration/components/RightIconButton.dart';
import 'package:chomp_migration/pages/online_game.dart';
import 'package:chomp_migration/pages/multi_player.dart';
import 'package:chomp_migration/pages/set_board.dart';
import 'package:flutter/material.dart';
import 'package:chomp_migration/pages/single_player.dart';

class GameStartPage extends StatefulWidget {
  static const String tag = 'game-start-page';

  @override
  _GameStartPage createState() => _GameStartPage();
}

class _GameStartPage extends State<GameStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Hero(
                  tag: 'chomp',
                  child: Material(
                    child: Text(
                      'Chomp',
                      style: TextStyle(
                          fontFamily: 'TheBite',
                          fontSize: 100,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    RightIconButton(
                      context: context,
                      tag: GameSetBoardPage.tag,
                      label: 'Single Player',
                      icon: Icons.person,
                      message: GameMainPage.tag,
                    ),
                    RightIconButton(
                      context: context,
                      tag: GameSetBoardPage.tag,
                      label: 'Two Player',
                      icon: Icons.people,
                      message: GameMainPageMultiPlayer.tag,
                    ),
                    RightIconButton(
                      context: context,
                      tag: GameSetBoardPage.tag,
                      label: 'Online',
                      icon: Icons.language,
                      message: GameMainPageOnline.tag,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
