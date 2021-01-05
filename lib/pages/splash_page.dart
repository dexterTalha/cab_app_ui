import 'dart:async';

import 'package:cab_app_ui/components/colored_backgroud.dart';
import 'package:cab_app_ui/routes/routes.dart';
import 'package:cab_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    handleTimer();
  }

  handleTimer() async {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, MyRoutes.getStarted);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                appName,
                style: splashTextStyle,
              ),
            ],
          ),
          Container()
        ],
      ),
    );
  }
}
