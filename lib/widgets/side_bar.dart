import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Center(
        child: Text(
          'SIDE BAR',
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
      ),
    );
  }
}
