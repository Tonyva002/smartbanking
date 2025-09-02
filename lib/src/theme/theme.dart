
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(

    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.blue,
      fontSize: 24),
      iconTheme: IconThemeData(
        color: Colors.blue
      )

    )
  );
}