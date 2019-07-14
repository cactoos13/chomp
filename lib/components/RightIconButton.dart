import 'package:chomp_migration/ScreenArguments.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:flutter/material.dart';

class RightIconButton extends StatelessWidget {
  final BuildContext context;
  final String tag;
  final String label;
  final IconData icon;
  final String message;

  RightIconButton({this.context, this.tag, this.label, this.icon, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: double.infinity),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        highlightElevation: 0,
        onPressed: () {
          resetGame();
          Navigator.pushNamed(context, tag,
              arguments: ScreenArguments(message));
        },
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 30,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
//              constraints: BoxConstraints(minHeight: 80),
//              color: Colors.brown,
                child: Icon(
                  icon,
                  color: Theme.of(context).accentColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}