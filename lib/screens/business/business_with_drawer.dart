import 'package:aapgblogflutter/screens/business/business_drawer.dart';
import 'package:aapgblogflutter/screens/business/business_screen.dart';
import 'package:flutter/material.dart';
class BusinessWithDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BusinessDrawer(),
          BusinessScreen()
        ],
      ),
    );
  }
}
