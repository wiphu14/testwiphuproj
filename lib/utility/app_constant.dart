import 'package:flutter/material.dart';

class AppConstant {
  static Color mainColor = const Color(0xff6D048E);

  static num fireScore = 1000;

  TextStyle h3Style({Color? color,double? fontSize,FontWeight? fontWeight }) => TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: 'Sriracha',
        color: color,
      );
  TextStyle h2Style({Color? color,double? fontSize,FontWeight? fontWeight }) => TextStyle(
        fontSize: fontSize ?? 24,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontFamily: 'Sriracha',
        color: color,
      );

  TextStyle h1Style({Color? color}) => TextStyle(
        fontSize:  48,
        fontWeight: FontWeight.bold,
        fontFamily: 'Sriracha',
        color: color,
      );
}
