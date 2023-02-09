import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Cloud Airline',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF272161, <int, Color>{
          50: Color(0xFFE5E4EC),
          100: Color(0xFFBEBCD0),
          200: Color(0xFF9390B0),
          300: Color(0xFF686490),
          400: Color(0xFF474279),
          500: Color(0xFF272161),
          600: Color(0xFF231D59),
          700: Color(0xFF1D184F),
          800: Color(0xFF171445),
          900: Color(0xFF0E0B33),
        }),
        appBarTheme: const AppBarTheme(
            color: CustomColors.MAIN_THEME,
            foregroundColor: CustomColors.SECOND_THEME,
            centerTitle: true),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cloud Airlines",
            style: TextStyle(color: CustomColors.SECOND_THEME),
          ),
          centerTitle: true,
        ),
        body: HomeScreen(),
      ),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
