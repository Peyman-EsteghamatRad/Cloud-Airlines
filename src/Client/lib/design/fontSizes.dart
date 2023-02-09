import 'package:flutter/cupertino.dart';

class FontSizes {

  static double factor = 3.5;

  static double BIGGY(BuildContext context){
    return MediaQuery.of(context).size.width / (4*factor);
  }

  static double h1(BuildContext context) {
    return MediaQuery.of(context).size.width / (7*factor);
  }

  static double h2(BuildContext context) {
    return MediaQuery.of(context).size.width / (10*factor);
  }

  static double h3(BuildContext context) {
    return MediaQuery.of(context).size.width / (18*factor);
  }

  static double normal(BuildContext context) {
    return MediaQuery.of(context).size.width / (20*factor);
  }

  static double description(BuildContext context) {
    return MediaQuery.of(context).size.width / (30*factor);
  }

  static double biggerText(BuildContext context) {
    return MediaQuery.of(context).size.width / (16*factor);
  }

  static double small(BuildContext context) {
    return MediaQuery.of(context).size.width / (28*factor);
  }

  static double extraSmall(BuildContext context) {
    return MediaQuery.of(context).size.width / (40*factor);
  }
}
