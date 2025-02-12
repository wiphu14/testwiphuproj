import 'package:flutter/material.dart';

class AppConstant {
  static Color mainColor = const Color(0xff6D048E);

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
