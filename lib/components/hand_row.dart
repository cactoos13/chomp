import 'package:flutter/material.dart';

class HandRow extends StatelessWidget {
  final int i;

  HandRow(this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: i,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              // todo how to differ buttons?
              onTap: () {
                final snackBar = SnackBar(
                  content: Text('$index pressed'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                    },
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Card(
                color: Colors.brown[800],
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  child: Text('$index'),
                ),
              ),
            );
          }),
    );
  }
}