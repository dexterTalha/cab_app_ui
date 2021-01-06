import 'package:cab_app_ui/auth/login/login_page.dart';
import 'package:cab_app_ui/auth/verification/otp_page.dart';
import 'package:cab_app_ui/pages/getting_started_page.dart';
import 'package:cab_app_ui/pages/splash_page.dart';
import 'package:flutter/cupertino.dart';

class MyRoutes {
  static const String splash = 'splash';
  static const String getStarted = 'get_started';
  static const String login = 'login';
  static const String verification = 'verification';

  Map<String, WidgetBuilder> routes() {
    return {
      splash: (BuildContext context) => SplashPage(),
      getStarted: (BuildContext context) => GetStartedPage(),
      login: (BuildContext context) => LoginPage(),
      verification: (BuildContext context) => OtpPage()
    };
  }
}
