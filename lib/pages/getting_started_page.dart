import 'package:cab_app_ui/components/colored_backgroud.dart';
import 'package:cab_app_ui/routes/routes.dart';
import 'package:cab_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              Center(
                child: FlutterLogo(
                  size: 100,
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  appName,
                  style: splashTextStyle.copyWith(fontSize: 40),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  appName,
                  style: splashTextStyle.copyWith(fontSize: 18),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(30),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, MyRoutes.login);
                  },
                  color: Colors.white,
                  child: Container(
                    height: 50,
                    width: size.width,
                    child: Center(
                      child: Text('Continue'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container()
        ],
      ),
    );
  }
}
