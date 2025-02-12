// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetAvater extends StatelessWidget {
  const WidgetAvater({
    Key? key,
    required this.backgroundImage,
    this.radius,
  }) : super(key: key);

  final ImageProvider<Object> backgroundImage;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return GFAvatar(
      backgroundImage: backgroundImage,
      radius: radius,
    );
  }
}
