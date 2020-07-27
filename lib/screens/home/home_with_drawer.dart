import 'package:flutter/material.dart';
import 'drawer_page.dart';
import 'home_page.dart';

class HomeWithDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DrawerPage(),
          HomePage()
        ],
      ),
    );
  }
}
