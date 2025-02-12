// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.type,
    this.size,
  }) : super(key: key);

  final IconData iconData;
  final Function() onPressed;
  final GFButtonType? type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      type: type ?? GFButtonType.transparent,
      size: size ?? GFSize.MEDIUM ,
    );
  }
}
