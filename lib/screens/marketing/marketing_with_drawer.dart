import 'package:aapgblogflutter/screens/home/drawer_page.dart';
import 'package:aapgblogflutter/screens/marketing/marketing_drawer.dart';
import 'package:aapgblogflutter/screens/marketing/marketing_screen.dart';
import 'package:flutter/material.dart';

class MarketingWithDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MarketingDrawer(),
          MarketingScreen()
        ],
      ),
    );
  }
}
