import 'package:flutter/material.dart';

class AppConstants {
  static const int primaryColor = 0xFF1CA2A8;
  static MaterialColor primaryBlue = const MaterialColor(primaryColor, {
    50: Color(0xFF1CA2A8),
    100: Color(0xFF1CA2A8),
    200: Color(0xFF1CA2A8),
    300: Color(0xFF1CA2A8),
    400: Color(0xFF1CA2A8),
    500: Color(0xFF1CA2A8),
    600: Color(0xFF1CA2A8),
    700: Color(0xFF1CA2A8),
    800: Color(0xFF1CA2A8),
    900: Color(0xFF1CA2A8),
  });
  static BoxDecoration decoration = BoxDecoration(
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color: Color(AppConstants.primaryColor),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 3),
      )
    ],
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: const Color(AppConstants.primaryColor),
    ),
  );
  static TextStyle tableColumnStyle = const TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle tableRowStyle = const TextStyle(
    color: Colors.blue,
    fontSize: 14,
  );
  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}
