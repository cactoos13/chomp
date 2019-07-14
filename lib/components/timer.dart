import 'dart:async';

import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Timer _timer;
  int _start;

  @override
  void initState() {
    _start = 30;
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Game Paused'.toUpperCase()),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.pause,
            size: 40,
          ),
          SizedBox(
            height: 10,
          ),
          Text('$_start'),
        ],
      ),
      actions: <Widget>[],
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    setState(() {
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(
              () {
                if (_start < 1) {
                  timer.cancel();
                  Navigator.of(context).pop();
                } else {
                  if (mounted) {
                    setState(() {
                      _start--;
                    });
                  }
                }
              },
            ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
