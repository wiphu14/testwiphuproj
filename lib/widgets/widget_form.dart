// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetFrom extends StatelessWidget {
  const WidgetFrom({
    Key? key,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.suffixIcon,
    this.keyForm,
    this.validator,
    this.controller,
    this.onChanged,
    this.radius,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Key? keyForm;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: TextFormField(onChanged: onChanged ,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          filled: true,
          fillColor: Theme.of(context).highlightColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 30),
              borderSide: BorderSide(color: Theme.of(context).highlightColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 30),
              borderSide: BorderSide(color: Theme.of(context).highlightColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 30),
              borderSide: BorderSide(color: Theme.of(context).highlightColor)),
        ),
      ),
    );
  }
}
