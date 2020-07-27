import 'package:aapgblogflutter/screens/design/design_drawer.dart';
import 'package:aapgblogflutter/screens/design/design_screen.dart';
import 'package:flutter/material.dart';

class DesignWithDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DesignDrawer(),
          DesignScreen()
        ],
      ),
    );
  }
}
