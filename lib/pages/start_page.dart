import 'package:chomp_migration/pages/leaderboard.dart';
import 'package:chomp_migration/pages/settings.dart';
import 'package:chomp_migration/components/my_dialogs.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chomp_migration/pages/game_modes.dart';
import 'package:flutter/material.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TempGameFirstPage extends StatefulWidget {
  static const String tag = 'temp-game-first-page';

  @override
  _TempGameFirstPageState createState() => _TempGameFirstPageState();
}

class _TempGameFirstPageState extends State<TempGameFirstPage> {
  bool firstTime = true;

  @override
  void initState() {
    id = faker.person.name();
    print('id: $id');
    if (firstTime) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        realInit();
        Future.delayed(
            const Duration(
              milliseconds: 2000,
            ),
            () => setState(() {
                  firstTime = false;
                }));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return firstTime
        ? Container(
            padding: EdgeInsets.all(80),
            color: Color(0xFFFFD8C6),
            child: Image.asset(
              'assets/skull2.png',
              color: Color(0xFF714F45),
            ),
          )
        : WillPopScope(
            onWillPop: () => onWillPopScope(context),
            child: Scaffold(
//              floatingActionButton: FloatingActionButton(
//                onPressed: () {
//                  Navigator.of(context).pushNamed(FourBoard.tag);
//                },
//              ),
              body: SafeArea(
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
//                        child: Image.asset('assets/logo.png'),
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
                      child: Text(id),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            highlightColor:
                                Theme.of(context).accentColor.withOpacity(0.1),
                            splashColor:
                                Theme.of(context).accentColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100),
                            onTap: () => Navigator.of(context)
                                .pushNamed(GameStartPage.tag),
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 200,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(Settings.tag),
                                  child: Icon(
                                    Icons.settings,
                                    size: 80,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(LeaderBoard.tag),
                                  child: Icon(
                                    FontAwesomeIcons.trophy,
                                    size: 70,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        child: Text('Play it on Web'),
                        onPressed: _launchURL,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _launchURL() async {
    const url = 'http://chompu.herokuapp.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}