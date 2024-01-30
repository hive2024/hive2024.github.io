import 'dart:ui';

import 'package:flutter/material.dart';

// const Color mainColor = Color(0XFF4CB2B6);
const Color mainColor = Color(0XFF113A56);
const Color color3C = Color(0xFF3C3A36);
const Color color4C = Color(0xFFD2EBED);
const Color color6D = Color(0xFF6D6D78);
const Color color1A = Color(0xFF1A1A1A);
const Color colorF4 = Color(0xFFF4F4F4);
const Color colorF5 = Color(0XFFf5b435);

const MaterialColor mainColors = MaterialColor(0XFF113A56, {
  50: Color(0XFF113A56),
  100: Color(0XFF113A56),
  200: Color(0XFF113A56),
  300: Color(0XFF113A56),
  400: Color(0XFF113A56),
  500: Color(0XFF113A56),
  600: Color(0XFF113A56),
  700: Color(0XFF113A56),
  800: Color(0XFF113A56),
  900: Color(0XFF113A56),
});

class TextStyles {
  static TextStyle debug = TextStyle(color: Colors.red, fontSize: 14);
  static TextStyle header =
      TextStyle(color: color3C, fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle header1 = TextStyle(color: Color(0xFF78746d), fontSize: 14);
  static TextStyle header2 = TextStyle(color: Color(0xFF1A1A1A), fontSize: 14);
  static TextStyle btn1 = TextStyle(color: colorF5, fontSize: 17);
  static TextStyle btn2 = TextStyle(color: mainColor, fontSize: 17);
  static TextStyle btn3 = TextStyle(color: color3C, fontSize: 20);
  static TextStyle btn4 = TextStyle(color: color1A, fontSize: 12);

  static TextStyle activityHeader =
      TextStyle(color: color3C, fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle activityDesc =
      TextStyle(color: color3C, fontSize: 14, fontWeight: FontWeight.bold);

  static TextStyle headerTask = TextStyle(color: color3C, fontSize: 20);

  static TextStyle header20 = TextStyle(color: color3C, fontSize: 20);
  static TextStyle header14 = TextStyle(color: color3C, fontSize: 14);
  static TextStyle header16 = TextStyle(color: color3C, fontSize: 16);
}

const MaterialColor MColor4C = MaterialColor(0xFFD2EBED, {
  50: color4C,
  100: color4C,
  200: color4C,
  300: color4C,
  400: color4C,
  500: color4C,
  600: color4C,
  700: color4C,
  800: color4C,
  900: color4C,
});

const MaterialColor MColorF4 = MaterialColor(0xFFF4F4F4, {
  50: colorF4,
  100: colorF4,
  200: colorF4,
  300: colorF4,
  400: colorF4,
  500: colorF4,
  600: colorF4,
  700: colorF4,
  800: colorF4,
  900: colorF4,
});

class TextColor {
  static Color main = mainColor;
}

const OutlineInputBorder mainInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2,
    color: mainColor,
  ),
);

const OutlineInputBorder forcedInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2,
    color: mainColor,
  ),
);

const OutlineInputBorder enableInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 1,
    color: mainColor,
  ),
);

const OutlineInputBorder disableInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    style: BorderStyle.solid,
    width: 1,
    color: mainColor,
  ),
);
