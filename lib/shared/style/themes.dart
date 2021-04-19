import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_udemy/shared/style/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Color(0xff333739),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
    ),
    backwardsCompatibility: false,
    backgroundColor: Color(0xff333739),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   type: BottomNavigationBarType.fixed,
  //   selectedItemColor: defaultColor,
  //   unselectedItemColor: Colors.grey,
  //   elevation: 20.0,
  //   backgroundColor: Color(0xff333739),

  // ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backwardsCompatibility: false,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
