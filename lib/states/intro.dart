// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_dialog.dart';
import 'package:wiphuproj/utility/app_service.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_form.dart';
import 'package:wiphuproj/widgets/widget_image.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final keyForm = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
            Colors.white,
            AppConstant.mainColor,
          ], radius: 1.2, center: Alignment(0, -0.5))),
          width: Get.width,
          height: Get.height,
          child: ListView(
            children: [
              const Widgetimage(name: 'images/intro4.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'หมอดู แม่นๆ',
                    style: AppConstant().h1Style(color: Colors.yellow),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ลงชื่อเข้าใช้งาน',
                    style: AppConstant().h2Style(color: Colors.indigo.shade500),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: WidgetButton(
                      text: 'ลูกค้า',
                      onPressed: () {
                        dialogCallLogin(user: true);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: GFColors.WHITE,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: WidgetButton(
                      text: 'หมอดู',
                      color: Colors.amber.shade800,
                      onPressed: () {
                        dialogCallLogin(user: false);
                      },
                      icon: const Icon(
                        Icons.person,
                        color: GFColors.WHITE,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogCallLogin({required bool user}) {
    AppDialog().normalDialog(
      displayCancel: true,
      icon: Widgetimage(name: user ? 'images/intro1.png' : 'images/intro4.png'),
      title: const Text('ลงชื่อเข้าใช้งาน'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(user ? 'สำหรับ ลูกค้าทั่วไป' : 'สำหรับ หมอดู'),
          const SizedBox(
            height: 16,
          ),
          WidgetFrom(
            controller: textEditingController,
            validator: (p0) {
              if (p0?.isEmpty ?? true) {
                return 'กรุณากรอกเบอร์ด้วย\n ถ้าต้องการ Login ด้วยเบอร์โทร';
              } else if (p0!.length != 10) {
                return 'เบอร์โทรผิด\n เบอร์โทรต้องมี 10 ตัวอักษร';
              } else {
                return null;
              }
            },
            keyForm: keyForm,
            labelText: 'โดยเบอร์โทร',
            hintText: '081xxxxxxx',
            keyboardType: TextInputType.phone,
            suffixIcon: WidgetIconButton(
              iconData: Icons.send,
              onPressed: () {

              //เอา keyboard ลง
              FocusManager.instance.primaryFocus?.unfocus();



                if (keyForm.currentState!.validate()) {

                  Get.back();

                  context.loaderOverlay.show();

                  AppService().processSendOTP(
                      phoneNumber: textEditingController.text, user: user);
                }
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          user
              ? WidgetButton(
                  color: Colors.indigo,
                  text: 'Facebook',
                  onPressed: () {},
                  icon: Icon(
                    Icons.facebook,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.size,
  }) : super(key: key);

  final IconData iconData;
  final Function() onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      type: GFButtonType.transparent,
      size: size ?? GFSize.MEDIUM,
    );
  }
}
