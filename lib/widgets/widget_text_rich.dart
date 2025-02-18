// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wiphuproj/utility/app_constant.dart';

class WidgetTextRich extends StatelessWidget {
  const WidgetTextRich({
    Key? key,
    required this.head,
    required this.value,
  }) : super(key: key);

  final String head;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      text: head,
      style: AppConstant()
          .h3Style(color: AppConstant.mainColor, fontWeight: FontWeight.bold),
      children: <InlineSpan>[
        TextSpan(text: ' : '),
        TextSpan(text: value, style: AppConstant().h3Style(color: Colors.black, fontWeight: FontWeight.normal)),
      ],
    ));
  }
}
