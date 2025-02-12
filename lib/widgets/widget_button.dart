// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.type,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final Widget? icon;
  final Color? color;
  final GFButtonType? type;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      color:  color ?? Theme.of(context).primaryColor,
      icon: icon,
      shape: GFButtonShape.pills,
      type: type?? GFButtonType.solid,
    );
  }
}
