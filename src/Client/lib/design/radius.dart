import 'package:flutter/cupertino.dart';

class CustomRadius {
  static Radius getBigRadius(BuildContext context) {
    return Radius.circular(MediaQuery.of(context).size.width / 10);
  }

  static Radius getStandartRadius(BuildContext context) {
    return Radius.circular(MediaQuery.of(context).size.width / 45); //from 25
  }

  static Radius getSmallRadius(BuildContext context) {
    return Radius.circular(MediaQuery.of(context).size.width / 40);
  }

  static Radius getExtraSmallRadius(BuildContext context) {
    return Radius.circular(MediaQuery.of(context).size.width / 80);
  }

  static BorderRadius getBigBorderRadius(BuildContext context) {
    return BorderRadius.circular(MediaQuery.of(context).size.width / 10);
  }

  static BorderRadius getStandartBorderRadius(BuildContext context) {
    return BorderRadius.circular(MediaQuery.of(context).size.width / 25);
  }

  static BorderRadius getSmallBorderRadius(BuildContext context) {
    return BorderRadius.circular(MediaQuery.of(context).size.width / 40);
  }

  static BorderRadius getExtraSmallBorderRadius(BuildContext context) {
    return BorderRadius.circular(MediaQuery.of(context).size.width / 80);
  }
}
