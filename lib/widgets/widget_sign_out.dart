import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wiphuproj/utility/app_dialog.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_image.dart';

class WidgetSignOut extends StatelessWidget {
  const WidgetSignOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetButton(
      text: 'SignOut',
      onPressed: () async {
        AppDialog().normalDialog(
            title: const Text('Comfirm Signout'),
            icon: const Widgetimage(name: 'images/signout.png', width: 160),
            content: Text('โปรด Confirm เพื่อการ Signout'),
            firstAction: WidgetButton(
                text: 'Confirm',
                onPressed: ()async{

                await FirebaseAuth.instance.signOut().whenComplete(() {
                  
                  Get.offAllNamed('/intro');

                },);


                },
                type: GFButtonType.outline2x),displayCancel: true);
      },
    );
  }
}
