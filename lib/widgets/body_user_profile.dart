import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wiphuproj/states/intro.dart';
import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_controller.dart';
import 'package:wiphuproj/utility/app_dialog.dart';
import 'package:wiphuproj/utility/app_service.dart';
import 'package:wiphuproj/widgets/widget_avatar.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_form.dart';
import 'package:wiphuproj/widgets/widget_text_rich.dart';

class BodyUserProfile extends StatefulWidget {
  const BodyUserProfile({
    super.key,
  });

  @override
  State<BodyUserProfile> createState() => _BodyUserProfileState();
}

class _BodyUserProfileState extends State<BodyUserProfile> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.currentUserModels.isEmpty
        ? SizedBox()
        : LoaderOverlay(
            child: ListView(
              children: [
                dispplayImage(),
                iconCamera(context),
                displayName(),
                displayBirthDate(),
                displayAge(),
                displayScore(),
                Text('List Favority โปรไฟล์'),
              ],
            ),
          ));
  }

  Widget displayScore() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetTextRich(
                head: 'Score',
                value: appController.currentUserModels.last.score.toString()),
            WidgetIconButton(
              iconData: Icons.shopping_cart,
              onPressed: () {},
              size: GFSize.LARGE,
            )
          ],
        ));
  }

  Widget displayAge() {
    return Obx(() => appController.currentUserModels.last.birthTimestamp == null
        ? SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetTextRich(head: 'อายุ ', value: AppService().calculateAge()),
            ],
          ));
  }

  Widget displayBirthDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => WidgetTextRich(
            head: 'วันเดือนปี เกิด',
            value: appController.currentUserModels.last.birthTimestamp == null
                ? 'ยังไม่ได้กำหนด'
                : AppService().changeTimestampToSring(
                    timestamp:
                        appController.currentUserModels.last.birthTimestamp))),
        WidgetIconButton(
            iconData: Icons.calendar_month,
            onPressed: () async {
              if (appController.chooseDateTime.isNotEmpty) {
                appController.chooseDateTime.clear();
              }

              DateTime? chooseDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 100),
                  lastDate: DateTime.now());

              if (chooseDate != null) {
                Map<String, dynamic> map =
                    appController.currentUserModels.last.toMap();

                map['birthTimestamp'] = Timestamp.fromDate(chooseDate);

                await AppService()
                    .processUpdateProfile(mapUserModel: map)
                    .whenComplete(
                  () {
                    AppService().findCurrentUserModel();
                  },
                );
              }
            },
            size: GFSize.LARGE),
      ],
    );
  }

  Row displayName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(appController.currentUserModels.last.displayName,
            style: AppConstant().h2Style()),
        WidgetIconButton(
          iconData: Icons.rate_review,
          size: GFSize.LARGE,
          onPressed: () async {
            appController.display.value = false;

            TextEditingController textEditingController =
                TextEditingController();

            textEditingController.text =
                appController.currentUserModels.last.displayName;

            AppDialog().normalDialog(
              title: Text(
                'แก้ไขชื่อ',
                style: AppConstant().h2Style(),
              ),
              content: WidgetFrom(
                controller: textEditingController,
                radius: 8,
                onChanged: (p0) {
                  if (p0.isEmpty) {
                    appController.display.value = false;
                  } else {
                    appController.display.value = true;
                  }
                },
              ),
              firstAction: Obx(() => appController.display.value
                  ? WidgetButton(
                      text: 'แก้ไข',
                      onPressed: () async {
                        Map<String, dynamic> map =
                            appController.currentUserModels.last.toMap();

                        map['displayName'] = textEditingController.text;

                        await AppService()
                            .processUpdateProfile(mapUserModel: map)
                            .whenComplete(
                          () {
                            Get.back();
                            AppService().findCurrentUserModel();
                          },
                        );
                      },
                      type: GFButtonType.outline2x,
                    )
                  : SizedBox()),
              secondAction: Obx(() => WidgetButton(
                  text: appController.display.value ? 'Cancel' : 'ok',
                  onPressed: () => Get.back())),
            );
          },
        )
      ],
    );
  }

  Row iconCamera(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.centerRight,
            width: 250,
            child: WidgetIconButton(
                iconData: Icons.photo_camera,
                onPressed: () async {
                  //ดึงภาพ
                  await AppService().processTakePhoto().whenComplete(
                    () async {
                      context.loaderOverlay.show();

                      //upload Image
                      String urlImage =
                          await AppService().processUploadImage(path: 'avatar');

                      Map<String, dynamic> map =
                          appController.currentUserModels.last.toMap();

                      map['urlImage'] = urlImage;

                      await AppService()
                          .processUpdateProfile(mapUserModel: map)
                          .whenComplete(
                        () {
                          context.loaderOverlay.hide();
                          AppService().findCurrentUserModel();
                        },
                      );
                    },
                  );
                },
                size: GFSize.LARGE)),
      ],
    );
  }

  Row dispplayImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetAvater(
          backgroundImage: appController.currentUserModels.last.urlImage.isEmpty
              ? AssetImage('images/avatar.png')
              : NetworkImage(appController.currentUserModels.last.urlImage),
          radius: 125,
        ),
      ],
    );
  }
}
