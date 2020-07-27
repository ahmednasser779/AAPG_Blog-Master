import 'package:aapgblogflutter/screens/business/business_with_drawer.dart';
import 'package:aapgblogflutter/screens/home/home_with_drawer.dart';
import 'package:aapgblogflutter/screens/marketing/marketing_with_drawer.dart';
import 'package:aapgblogflutter/screens/settings/settings_screen.dart';
import 'package:aapgblogflutter/screens/soft_skills/skills_with_drawer.dart';
import 'package:aapgblogflutter/screens/technology/tech_with_drawer.dart';
import 'package:flutter/material.dart';

bool closingDesignDrawer = false;

class DesignDrawer extends StatefulWidget {
  @override
  _DesignDrawerState createState() => _DesignDrawerState();
}

class _DesignDrawerState extends State<DesignDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: isDarkMode? Colors.black54: Colors.green[900],
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 160,
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blog_logo.png'))),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('الأقسام',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.right),
          ),
          SizedBox(height: 8),
          Divider(height: 2, color: Colors.white54),
          ListTile(
            trailing: Icon(
              Icons.public,
              color: Colors.white,
            ),
            title: Text('التسويق',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
            onTap: () {
              setState(() {
                closingDesignDrawer = true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MarketingWithDrawer();
              }));
            },
          ),
          ListTile(
            trailing: Icon(Icons.business_center, color: Colors.white),
            title: Text('إدارة الأعمال',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
            onTap: () {
              setState(() {
                closingDesignDrawer = true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BusinessWithDrawer();
              }));
            },
          ),
          ListTile(
            trailing: Icon(Icons.laptop_windows, color: Colors.white),
            title: Text('التكنولوجيا',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
            onTap: () {
              setState(() {
                closingDesignDrawer = true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TechWithDrawer();
              }));
            },
          ),
          ListTile(
            trailing: Icon(Icons.group_work, color: Colors.white),
            title: Text('المهارات الشخصية',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
            onTap: () {
              setState(() {
                closingDesignDrawer = true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SkillsWithDrawer();
              }));
            },
          ),
          SizedBox(height: 100),
          ListTile(
            trailing: Icon(Icons.home, color: Colors.white),
            title: Text('الرئيسية',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
            onTap: () {
              setState(() {
                closingDesignDrawer = true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HomeWithDrawer();
              }));
            },
          ),
          ListTile(
            trailing: Icon(Icons.settings, color: Colors.white),
            title: Text('الإعدادات',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right),
            onTap: () {
              setState(() {
                closingDesignDrawer = true;
              });
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SettingsScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
