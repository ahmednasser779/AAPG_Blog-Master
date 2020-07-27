import 'package:aapgblogflutter/bloc/theme.dart';
import 'package:aapgblogflutter/screens/home/home_with_drawer.dart';
import 'package:aapgblogflutter/services/blog_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

setupLocator(){
  GetIt.instance.registerLazySingleton(() => BlogServices());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme()
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AAPG Blog',
      home: HomeWithDrawer(),
      theme: theme.getTheme(),
    );
  }
}
