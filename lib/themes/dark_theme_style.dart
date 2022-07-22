import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context){
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,

      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),

      indicatorColor: isDarkTheme ? const Color(0xff0e1d36) : const Color(0xffcbdcf8),

      hintColor: isDarkTheme ? const Color(0xff280c0b) : const Color(0xffeeced3),

      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffa8dab5),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),

      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0
      )
    );
  }
}