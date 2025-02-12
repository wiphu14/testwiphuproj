// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_service.dart';
import 'package:wiphuproj/widgets/widget_image.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({
    Key? key,
    required this.phoneNumber,
    required this.verifyId,
    required this.user,
  }) : super(key: key);

  final String phoneNumber;
  final String verifyId;
  final bool user;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Widgetimage(name: 'images/intro2.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'โปรดกรอกรหัส OTP',
                  style: AppConstant().h2Style(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPTextField(
                  fieldStyle: FieldStyle.box,
                  width: 250,
                  length: 6,
                  onCompleted: (value) {
      
                    context.loaderOverlay.show();
      
                    AppService().processCheckOTP(
                        otp: value, verifyId: verifyId, phoneNumber: phoneNumber, context: context, user: user);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
