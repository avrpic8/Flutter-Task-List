import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: primaryColor,
        primaryVariant: primaryVariant,
        secondary: primaryColor,
        onSecondary: Colors.white,
        background: const Color(0xfff3f5f8),
        surface: const Color(0xffFAFAFA),
        onSurface: primaryTextColor,
        //onBackground: primaryTextColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
        headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(color: primaryTextColor),
        subtitle1: TextStyle(color: primaryTextColor),
      )),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: secondryTextColor),
          border: InputBorder.none),
    );
  }
}
