import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiphuproj/widgets/widget_button.dart';

class AppDialog {
  void normalDialog({
    Widget? title,
    Widget? icon,
    Widget? content,
    Widget? firstAction,
    Widget? secondAction,
    bool? displayCancel,
  }) {
    Get.dialog(AlertDialog(scrollable: true,
      icon: icon,
      title: title,
      content: content,
      actions: [
        firstAction ?? const SizedBox(),
        secondAction ??
            WidgetButton(
              text: displayCancel ?? false ? 'Cancel' : 'Ok',
              onPressed: () => Get.back(),
            )
      ],
    ), barrierDismissible: false );
  }
}
