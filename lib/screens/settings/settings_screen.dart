import 'package:aapgblogflutter/bloc/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isDarkMode = false;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode? Colors.black54: Colors.green[700],
        centerTitle: true,
        title: Text('الإعدادات', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Dark Mode', style: TextStyle(fontSize: 20)),
            Switch(
              activeColor: Colors.green,
              value: isDarkMode,
              onChanged: (value){
                setState(() {
                  isDarkMode = value;
                });
                if(isDarkMode){
                  _themeChanger.setTheme(ThemeData.dark());
                }
                else{
                  _themeChanger.setTheme(ThemeData.light());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
