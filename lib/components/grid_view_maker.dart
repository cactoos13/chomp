import 'package:flutter/material.dart';
import 'package:chomp_migration/game_logic.dart';

class GridViewMaker extends StatefulWidget {

  final Function func;

  const GridViewMaker({this.func});

  @override
  _GridViewMakerState createState() => _GridViewMakerState();
}

class _GridViewMakerState extends State<GridViewMaker> {
  @override
  Widget build(BuildContext context) {
    double myMargin = 3;
    double borderWidth = 3;

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 10,
      shrinkWrap: true,
      children: List.generate(100, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.func(context, index);
//              popChompItem(index);
            });
//            secondVector[index] = 0;
            // final snackBar = SnackBar(
            //   content: Text("You can't play with an empty board!"),
            // );
            // Scaffold.of(context).showSnackBar(snackBar);
          },
          child: secondVector[index] == 0
              ? Container()
              : Container(
            color: Colors.brown[800],
            // margin: EdgeInsets.all(1),
            child: Container(
              margin: EdgeInsets.all(myMargin),
              color: Theme.of(context).accentColor,
              alignment: Alignment.center,
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
                // height: 32,
                // width: 32,
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(2),
                  child: index == 0
                      ? Image.asset(
                    'assets/skull2.png',
                    color: Colors.white,
                  )
                      : null,
                ),
                // child: Text(
                //   '$index',
                //   style: TextStyle(color: Theme.of(context).primaryColor),
                // ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
