import 'package:cab_app_ui/auth/login/login_interface.dart';
import 'package:cab_app_ui/auth/login/login_ui.dart';
import 'package:cab_app_ui/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginInterface {
  @override
  Widget build(BuildContext context) {
    return LoginUI(this);
  }

  @override
  void loginWithMobile(String mobileNumber) {
    Navigator.pushReplacementNamed(context, MyRoutes.verification, arguments: mobileNumber);
  }
}
