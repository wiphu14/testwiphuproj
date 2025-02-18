import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wiphuproj/models/user_model.dart';
import 'package:wiphuproj/states/otp_page.dart';
import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_controller.dart';
import 'package:wiphuproj/utility/app_dialog.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_form.dart';
import 'package:wiphuproj/widgets/widget_image.dart';
import 'package:path/path.dart';

class AppService {
  AppController appController = Get.put(AppController());

  String calculateAge() {
    var age = DateTime.now().year -
        appController.currentUserModels.last.birthTimestamp.toDate().year;

    return '$age ปี';
  }

  String changeTimestampToSring({required Timestamp timestamp}) {
    DateTime dateTime = timestamp.toDate();

    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    String string = dateFormat.format(dateTime);

    return string;
  }

  Future<List<UserModel>> readAllProphet() async {
    List<UserModel> userModels = <UserModel>[];

    var result = await FirebaseFirestore.instance
        .collection('user')
        .where('user', isEqualTo: false)
        .get();

    if (result.docs.isNotEmpty) {
      for (var element in result.docs) {
        UserModel model = UserModel.fromMap(element.data());

        userModels.add(model);
      }
    }

    return userModels;
  }

  Future<void> processUpdateProfile(
      {required Map<String, dynamic> mapUserModel}) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(appController.currentUserModels.last.uid)
        .update(mapUserModel)
        .whenComplete(
      () {
        findCurrentUserModel();
      },
    );
  }

  Future<void> findCurrentUserModel() async {
    var user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      var result = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();

      if (result.data() != null) {
        UserModel model = UserModel.fromMap(result.data()!);

        appController.currentUserModels.add(model);
      }
    }
  }

  Future<void> processTakePhoto() async {
    var result = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      File file = File(result.path);
      appController.files.add(file);

      String nameFile = basename(file.path);
      appController.nameFiles.add(nameFile);
    }
  }

  Future<String> processUploadImage({required String path}) async {
    String? urlImage;

    if (appController.files.isNotEmpty) {
      FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
          bucket: 'gs://wiphuproject.firebasestorage.app');

      Reference reference =
          firebaseStorage.ref().child('$path/${DateTime.now().toString()}.jpg');

      UploadTask uploadTask = reference.putFile(appController.files.last);

      await uploadTask.whenComplete(
        () async {
          urlImage = await reference.getDownloadURL();
        },
      );
    }

    return urlImage ?? '';
  }

  Future<void> processCheckOTP({
    required String otp,
    required String verifyId,
    required String phoneNumber,
    required BuildContext context,
    required bool user,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: otp,
      ))
          .then(
        (value) async {
          String uid = value.user!.uid;
          print('Login Sucess uid --> $uid');

          var result = await FirebaseFirestore.instance
              .collection('user')
              .where('phoneNumber', isEqualTo: phoneNumber)
              .get();

          //เช็คเบอร์นี้ลงทะเบียนแล้วหรือยัง

          if (result.docs.isEmpty) {
            //ยังไม่ลงทะเบียน
            final keyForm = GlobalKey<FormState>();
            TextEditingController textEditingController =
                TextEditingController();

            AppDialog().normalDialog(
                icon: Widgetimage(
                  name: 'images/intro4.png',
                  width: 200,
                ),
                title: Text('Display Name ?'),
                content: WidgetFrom(
                  labelText: 'DisplayName:',
                  keyForm: keyForm,
                  controller: textEditingController,
                  validator: (p0) {
                    if (p0?.isEmpty ?? true) {
                      return 'โปรดกรอก DispayName';
                    } else {
                      return null;
                    }
                  },
                ),
                secondAction: WidgetButton(
                  text: 'save',
                  onPressed: () async {
                    if (keyForm.currentState!.validate()) {
                      UserModel userModel = UserModel(
                          uid: uid,
                          displayName: textEditingController.text,
                          phoneNumber: phoneNumber,
                          user: user,
                          score: AppConstant.fireScore);

                      await FirebaseFirestore.instance
                          .collection('user')
                          .doc(uid)
                          .set(userModel.toMap())
                          .whenComplete(
                        () {
                          Get.snackbar('สมัครสมาชิกสำเร็จ',
                              'ยินดีต้อนรับ คุณ ${textEditingController.text} สู่ App หมดูแม่นๆ',
                              backgroundColor: Theme.of(context).primaryColor,
                              colorText: GFColors.WHITE);

                          Get.offAllNamed(
                              user ? '/mainHomeUser' : '/mainHomeProphet');
                        },
                      );
                    }
                  },
                  type: GFButtonType.outline2x,
                ));
          } else {
            //คนเก่าเคยลงทะเบียนแล้ว
            Get.snackbar('Login สำเร็จ', 'ยินดีต้อนรับ MyApp',
                backgroundColor: Theme.of(context).primaryColor,
                colorText: GFColors.WHITE);

            for (var element in result.docs) {
              UserModel userModel = UserModel.fromMap(element.data());

              Get.offAllNamed(
                  userModel.user! ? '/mainHomeUser' : '/mainHomeProphet');
            }
          }
        },
      );
    } catch (e) {
      context.loaderOverlay.hide();

      Get.snackbar(
        'OTP ผิด',
        'กรุณากรอก OTP ใหม่',
        backgroundColor: GFColors.DANGER,
        colorText: GFColors.WHITE,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> processSendOTP(
      {required String phoneNumber, required bool user}) async {
    String phone = phoneNumber.substring(1);
    phone = '+66$phone';
    print('phone --> $phone');

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 90),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        Get.to(OtpPage(
            phoneNumber: phoneNumber, verifyId: verificationId, user: user));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
