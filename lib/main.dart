import 'package:cab_app_ui/pages/splash_page.dart';
import 'package:cab_app_ui/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: MyRoutes().routes(),
      home: SplashPage(),
    );
  }
}
