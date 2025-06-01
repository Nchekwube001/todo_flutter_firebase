import 'package:flutter/material.dart';

class SizeConfig {
  static double deviceHeight = 0.0;
  static double deviceWidth = 0.0;

  static void init(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }

  static double getProportionateHeight(double inputHeight) {
    return (inputHeight / 812.0) * deviceHeight;
  }

  static double getProportionateWidth(double inputWidth) {
    return (inputWidth / 375.0) * deviceWidth;
  }
}
