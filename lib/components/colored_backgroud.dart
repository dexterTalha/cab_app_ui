import 'package:cab_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';

class ColoredBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColorOne,
            gradientColorTwo,
            gradientColorThree,
          ],
        ),
      ),
    );
  }
}
