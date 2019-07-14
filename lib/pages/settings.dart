import 'package:chomp_migration/components/settings_button.dart';
import 'package:chomp_migration/game_logic.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  static const String tag = 'settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
//    setState(() {
    _controller.text = id;
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.music_note,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.volume_off,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'ID',
                  ),
                  onChanged: (data) {
                    if (data == '')
                      id = faker.person.name();
                    else
                      id = data;
                  },
                  onTap: () {
                    _controller.text = '';
                  },
                ),
              ),
              SettingsButton(
                context: context,
                label: 'Rate',
                icon: Icons.star,
              ),
              SettingsButton(
                context: context,
                label: 'Share',
                icon: Icons.share,
              ),
              SettingsButton(
                context: context,
                label: 'Support',
                icon: Icons.attach_money,
              ),
              SettingsButton(
                context: context,
                label: 'Credits',
                icon: Icons.credit_card,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
