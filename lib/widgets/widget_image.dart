// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Widgetimage extends StatelessWidget {
  const Widgetimage({
    Key? key,
    required this.name,
    this.width,
  }) : super(key: key);

  final String name;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(name,width: width ,);
  }
}
