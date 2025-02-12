import 'package:flutter/material.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_sign_out.dart';

class MainHomeUser extends StatelessWidget {
  const MainHomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Main Home(ลูกค้า)'),
      actions: [
        WidgetSignOut()
      ],
    ));
  }
}
