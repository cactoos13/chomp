import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  static const String tag = 'leaderboard';

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  color: Colors.blue,
                ),
                background: Container(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      Text('something'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: ListView.builder(
              itemCount: 40,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CircleAvatar(
//                              maxRadius: 50,
//                              minRadius: 40,
                            radius: 40,
                            backgroundColor: Theme.of(context).accentColor,
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                    'assets/fake_profiles/fake${index % 9 + 1}.jpg'),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'name${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('score: ${(index + 1) * 7}'),
                            ],
                          ),
                          Text('rank ${index + 1}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

//my Code
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//class LeaderBoard extends StatefulWidget {
//  static const String tag = 'leaderboard';
//
//  @override
//  _LeaderBoardState createState() => _LeaderBoardState();
//}
//
//class _LeaderBoardState extends State<LeaderBoard> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 4,
//        title: Text('LeaderBoard'),
//      ),
//      body: Column(
//        children: <Widget>[
//          //todo make it sliver app bar
//          Container(
//            width: double.infinity,
//            child: Material(
//              elevation: 4,
//              child: Container(
//                margin: EdgeInsets.symmetric(vertical: 20),
//                child: Column(
//                  children: <Widget>[
//                    CircleAvatar(
//                      radius: 60,
//                      child: Padding(
//                        padding: EdgeInsets.all(4),
//                        child: ClipRRect(
//                          borderRadius: BorderRadius.circular(100),
//                          child: Image.asset('assets/fake_profiles/fake10.jpg'),
//                        ),
//                      ),
//                      backgroundColor: Theme.of(context).accentColor,
//                    ),
//                    Text(
//                      'Your Score: 100',
//                      style: TextStyle(fontSize: 20),
//                    ),
//                    Text(
//                      'Your Rank: 1000',
//                      style: TextStyle(fontSize: 20),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//          Expanded(
//            child: ListView.builder(
//                itemCount: 40,
//                itemBuilder: (BuildContext context, int index) {
//                  return Column(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.symmetric(vertical: 10),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            CircleAvatar(
////                              maxRadius: 50,
////                              minRadius: 40,
//                              radius: 40,
//                              backgroundColor: Theme.of(context).accentColor,
//                              child: Padding(
//                                padding: EdgeInsets.all(4),
//                                child: ClipRRect(
//                                  borderRadius: BorderRadius.circular(100),
//                                  child: Image.asset(
//                                      'assets/fake_profiles/fake${index % 9 + 1}.jpg'),
//                                ),
//                              ),
//                            ),
//                            Column(
//                              children: <Widget>[
//                                Text(
//                                  'name${index + 1}',
//                                  style: TextStyle(fontWeight: FontWeight.bold),
//                                ),
//                                Text('score: ${(index + 1) * 7}'),
//                              ],
//                            ),
//                            Text('rank ${index + 1}'),
//                          ],
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 20),
//                        child: Divider(),
//                      ),
//                    ],
//                  );
//                }),
//          )
//        ],
//      ),
//    );
//  }
//}
//
////
////FlexibleSpaceBar(
////centerTitle: true,
////title: Text("Collapsing Toolbar",
////style: TextStyle(
////color: Colors.white,
////fontSize: 16.0,
////)),
////background: Image.network(
////"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
////fit: BoxFit.cover,
////))