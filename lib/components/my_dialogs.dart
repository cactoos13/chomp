import 'package:audioplayers/audio_cache.dart';
import 'package:chomp_migration/Pages/game_modes.dart';
import 'package:flutter/material.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<bool> onWillPopScope(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Exit?'),
              content: Text('Are you sure you want to exit the game?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    resetGame();
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
      ) ??
      false;
}

Future<void> gameOverDialog(BuildContext context, String type) {
  final player = AudioCache();
  Widget content;
  switch (type) {
    case 'single':
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            turn ? FontAwesomeIcons.skull : FontAwesomeIcons.trophy,
            color: turn ? Colors.black : Colors.yellow[900],
            size: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text(turn ? 'You Lost' : 'You Won'),
        ],
      );
      player.play(
        turn ? 'audios/death.mp3' : 'audios/win.mp3',
      );
//          mode: PlayerMode.LOW_LATENCY);
      player.play(
        turn ? 'audios/death.mp3' : 'audios/youWin.mp3',
      );
//          mode: PlayerMode.LOW_LATENCY);
      break;
    case 'multi':
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
          Text('Player ${turn ? '2' : '1'} Won')
        ],
      );
      player.play(
        'audios/win.mp3',
      );
//          mode: PlayerMode.LOW_LATENCY);
      break;
    case 'online':
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            turn ? FontAwesomeIcons.skull : FontAwesomeIcons.trophy,
            color: turn ? Colors.black : Colors.yellow[900],
            size: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text(turn ? 'You Lost' : 'You Won'),
        ],
      );
      player.play(
        turn ? 'audios/death.mp3' : 'audios/win.mp3',
      );
//          mode: PlayerMode.LOW_LATENCY);
      player.play(
        turn ? 'audios/death.mp3' : 'audios/youWin.mp3',
      );
//          mode: PlayerMode.LOW_LATENCY);
      break;
  }
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('GAME OVER'),
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