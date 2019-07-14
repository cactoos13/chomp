import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final IconData icon;

  SettingsButton({this.context, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: double.infinity),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        onPressed: () {},
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