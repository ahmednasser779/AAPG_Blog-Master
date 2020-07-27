import 'package:aapgblogflutter/screens/technology/tech_drawer.dart';
import 'package:aapgblogflutter/screens/technology/tech_screen.dart';
import 'package:flutter/material.dart';

class TechWithDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TechDrawer(),
          TechScreen()
        ],
      ),
    );
  }
}
