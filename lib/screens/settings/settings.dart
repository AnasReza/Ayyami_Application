import 'package:ayyami/constants/colors.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'SETTINGS',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
