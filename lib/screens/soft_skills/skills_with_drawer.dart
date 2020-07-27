import 'package:aapgblogflutter/screens/soft_skills/skills_drawer.dart';
import 'package:aapgblogflutter/screens/soft_skills/skills_screen.dart';
import 'package:flutter/material.dart';

class SkillsWithDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SkillsDrawer(),
          SkillsScreen()
        ],
      ),
    );
  }
}
