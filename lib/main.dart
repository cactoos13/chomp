import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import 'package:chomp_migration/pages/leaderboard.dart';
import 'package:chomp_migration/pages/settings.dart';
import 'package:chomp_migration/pages/single_player.dart';
import 'package:chomp_migration/pages/multi_player.dart';
import 'package:chomp_migration/pages/online_game.dart';
import 'package:chomp_migration/pages/set_board.dart';
import 'package:chomp_migration/pages/game_modes.dart';
import 'package:chomp_migration/pages/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    GameStartPage.tag: (context) => GameStartPage(),
    GameMainPage.tag: (context) => GameMainPage(),
    GameMainPageMultiPlayer.tag: (context) => GameMainPageMultiPlayer(),
    GameMainPageOnline.tag: (context) => GameMainPageOnline(),
    GameSetBoardPage.tag: (context) => GameSetBoardPage(),
    TempGameFirstPage.tag: (context) => TempGameFirstPage(),
    Settings.tag: (context) => Settings(),
    LeaderBoard.tag: (context) => LeaderBoard(),
  };

  final accentColor = Color(0xFF714F45);
  final primaryColor = Color(0xFFFFD8C6);

  final primaryColorDark = Color(0xFF714F45);
  final backgroundColor = Color(0xFFFFD8C6);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Chomp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: accentColor,
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        splashColor: accentColor,
        hintColor: backgroundColor,
        cardColor: primaryColor,
        dividerColor: Colors.brown[900],
        canvasColor: backgroundColor,
        appBarTheme: AppBarTheme(elevation: 0),
        textTheme: TextTheme(
          subhead: TextStyle(
            fontSize: 18,
          ),
          button: TextStyle(
            fontSize: 18,
            color: accentColor,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: accentColor.withOpacity(0.25),
          textTheme: ButtonTextTheme.accent,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        iconTheme: IconThemeData(
          color: accentColor,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: primaryColor,
          titleTextStyle: TextStyle(
            color: accentColor,
            fontSize: 30,
          ),
          contentTextStyle: TextStyle(
            color: accentColor,
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: accentColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: accentColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: accentColor),
          ),
          hintStyle: TextStyle(color: accentColor),
          helperStyle: TextStyle(color: accentColor),
          labelStyle: TextStyle(color: accentColor),
        ),
      ),
      home: TempGameFirstPage(),
      routes: routes,
    );
  }
}
