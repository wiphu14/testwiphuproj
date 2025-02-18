// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wiphuproj/models/skill_model.dart';
import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_controller.dart';
import 'package:wiphuproj/utility/app_dialog.dart';
import 'package:wiphuproj/utility/app_service.dart';
import 'package:wiphuproj/widgets/widget_avatar.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_form.dart';

import 'package:wiphuproj/widgets/widget_icon_button.dart';
import 'package:wiphuproj/widgets/widget_image.dart';
import 'package:wiphuproj/widgets/widget_image_network.dart';

class BodyProfileProphet extends StatefulWidget {
  const BodyProfileProphet({
    super.key,
  });

  @override
  State<BodyProfileProphet> createState() => _BodyProfileProphetState();
}

class _BodyProfileProphetState extends State<BodyProfileProphet> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Obx(() => Container(
                width: Get.width,
                height: Get.height / 2,
                decoration: BoxDecoration(border: Border.all()),
                child: appController.currentUserModels.last.urlImage.isEmpty
                    ? Widgetimage(name: 'images/avatar.png')
                    : WidgetImageNetwork(
                        src: appController.currentUserModels.last.urlImage,
                        fit: BoxFit.cover,
                      ))),
            Positioned(
                top: Get.height / 2 - 64,
                right: 32,
                child: WidgetIconButton(
                  iconData: Icons.photo_camera,
                  size: GFSize.LARGE,
                  onPressed: () async {
                    AppService().processTakePhoto().whenComplete(
                      () async {
                        context.loaderOverlay.show();

                        String urlImage = await AppService()
                            .processUploadImage(path: 'avatar');
                        print('##27jan urlImage --> $urlImage ');

                        Map<String, dynamic> map =
                            appController.currentUserModels.last.toMap();

                        map['urlImage'] = urlImage;

                        AppService()
                            .processUpdateProfile(mapUserModel: map)
                            .whenComplete(
                          () {
                            context.loaderOverlay.hide();
                          },
                        );
                      },
                    );
                  },
                )),
            Positioned(
                top: Get.height / 2 - 60,
                left: 16,
                child: Obx(() => WidgetAvater(
                    backgroundImage:
                        appController.currentUserModels.last.urlImage.isEmpty
                            ? AssetImage('images/avatar.png')
                            : NetworkImage(
                                appController.currentUserModels.last.urlImage),
                    radius: 60))),
            Positioned(
              top: Get.height / 2 + 60 + 16,
              child: SizedBox(
                width: Get.width,
                height: Get.height - (Get.height / 2 + 60 + 16),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Text('Skill',
                                      style: AppConstant().h3Style(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  WidgetButton(
                                      text: 'เลือกสกิว',
                                      onPressed: () {
                                        AppDialog().normalDialog(
                                            title: Text('เลือกสกิว;'),
                                            content: Text('list Skill'));
                                      }),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  WidgetButton(
                                      text: 'กรอกสกิว',
                                      type: GFButtonType.outline,
                                      onPressed: () {
                                        TextEditingController
                                            textEditingController =
                                            TextEditingController();

                                        appController.display.value = false;

                                        AppDialog().normalDialog(
                                            title: Text('กรอกสกิว;'),
                                            content: WidgetFrom(
                                                onChanged: (p0) {
                                                  if (p0.isEmpty) {
                                                    appController
                                                        .display.value = false;
                                                  } else {
                                                    appController
                                                        .display.value = true;
                                                  }
                                                },
                                                radius: 8,
                                                controller:
                                                    textEditingController,
                                                hintText:
                                                    'สกิวใหม่ต้องไม่ซ้ำสกิวเดิม'),
                                            firstAction:
                                                Obx(
                                                    () =>
                                                        appController
                                                                .display.value
                                                            ? WidgetButton(
                                                                text: 'บันทึก',
                                                                onPressed:
                                                                    () async {
                                                                  SkillModel skillModel = SkillModel(
                                                                      nameSkill:
                                                                          textEditingController
                                                                              .text,
                                                                      uidRecord: appController
                                                                          .currentUserModels
                                                                          .last
                                                                          .uid,
                                                                      timestamp:
                                                                          Timestamp.fromDate(
                                                                              DateTime.now()));
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'skill')
                                                                      .doc()
                                                                      .set(skillModel
                                                                          .toMap())
                                                                      .whenComplete(
                                                                        () {
                                                                          Get.back();
                                                                        },
                                                                      );
                                                                },
                                                                type: GFButtonType
                                                                    .outline2x,
                                                              )
                                                            : SizedBox()));
                                      }),
                                ],
                              ),
                              SizedBox(height: 16),
                              displayName(),
                              SizedBox(height: 16),
                              displaySlogan(),
                              SizedBox(height: 16),
                              displayDescrip(),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row displayDescrip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => appController.currentUserModels.isEmpty
            ? SizedBox()
            : SizedBox(
                width: Get.width * 0.6,
                child: Text(
                    appController.currentUserModels.last.description.isEmpty
                        ? 'Non Description'
                        : appController.currentUserModels.last.description,
                    style: AppConstant()
                        .h2Style(fontWeight: FontWeight.normal, fontSize: 16)),
              )),
        WidgetIconButton(
            iconData: Icons.edit,
            onPressed: () {
              dialogCallDescription();
            }),
      ],
    );
  }

  Row displaySlogan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => appController.currentUserModels.isEmpty
            ? SizedBox()
            : SizedBox(
                width: Get.width * 0.6,
                child: Text(
                    appController.currentUserModels.last.slogan.isEmpty
                        ? 'Non Slogan ?'
                        : appController.currentUserModels.last.slogan,
                    style: AppConstant()
                        .h2Style(fontWeight: FontWeight.normal, fontSize: 16)),
              )),
        WidgetIconButton(
            iconData: Icons.edit,
            onPressed: () {
              dialogCallSlogan();
            }),
      ],
    );
  }

  Row displayName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => appController.currentUserModels.isEmpty
            ? SizedBox()
            : SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  appController.currentUserModels.last.displayName,
                  style: AppConstant().h2Style(),
                ),
              )),
        WidgetIconButton(
            iconData: Icons.edit,
            onPressed: () {
              dialogCallName();
            }),
      ],
    );
  }

  void dialogCallName() {
    TextEditingController textEditingController = TextEditingController();

    appController.display.value;

    textEditingController.text =
        appController.currentUserModels.last.displayName;

    AppDialog().normalDialog(
        title: Text('แก้ไขชื่อ'),
        icon: Obx(() => appController.currentUserModels.last.urlImage.isEmpty
            ? Widgetimage(name: 'images/avatar.png')
            : WidgetImageNetwork(
                src: appController.currentUserModels.last.urlImage,
                width: Get.width,
                height: Get.width / 2,
                fit: BoxFit.cover)),
        content: WidgetFrom(
          controller: textEditingController,
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
                text: 'แก้ไขชื่อ',
                onPressed: () async {
                  Map<String, dynamic> map =
                      appController.currentUserModels.last.toMap();

                  map['displayName'] = textEditingController.text;

                  await AppService()
                      .processUpdateProfile(mapUserModel: map)
                      .whenComplete(
                    () {
                      Get.back();
                    },
                  );
                },
                type: GFButtonType.outline2x,
              )
            : SizedBox()),
        secondAction: Obx(() => WidgetButton(
            text: appController.display.value ? 'cancel' : 'ok',
            onPressed: () => Get.back())));
  }

  void dialogCallSlogan() {
    TextEditingController textEditingController = TextEditingController();

    appController.display.value;

    textEditingController.text = appController.currentUserModels.last.slogan;

    AppDialog().normalDialog(
        title: Text('แก้ไข สโลแกน'),
        icon: Obx(() => appController.currentUserModels.last.urlImage.isEmpty
            ? Widgetimage(name: 'images/avatar.png')
            : WidgetImageNetwork(
                src: appController.currentUserModels.last.urlImage,
                width: Get.width,
                height: Get.width / 2,
                fit: BoxFit.cover)),
        content: WidgetFrom(
          controller: textEditingController,
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
                text: 'แก้ไข สโลแกน',
                onPressed: () async {
                  Map<String, dynamic> map =
                      appController.currentUserModels.last.toMap();

                  map['slogan'] = textEditingController.text;

                  await AppService()
                      .processUpdateProfile(mapUserModel: map)
                      .whenComplete(
                    () {
                      Get.back();
                    },
                  );
                },
                type: GFButtonType.outline2x,
              )
            : SizedBox()),
        secondAction: Obx(() => WidgetButton(
            text: appController.display.value ? 'cancel' : 'ok',
            onPressed: () => Get.back())));
  }

  void dialogCallDescription() {
    TextEditingController textEditingController = TextEditingController();

    appController.display.value;

    textEditingController.text =
        appController.currentUserModels.last.description;

    AppDialog().normalDialog(
        title: Text('แก้ไข คำบรรยาย'),
        icon: Obx(() => appController.currentUserModels.last.urlImage.isEmpty
            ? Widgetimage(name: 'images/avatar.png')
            : WidgetImageNetwork(
                src: appController.currentUserModels.last.urlImage,
                width: Get.width,
                height: Get.width / 2,
                fit: BoxFit.cover)),
        content: WidgetFrom(
          controller: textEditingController,
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
                text: 'แก้ไข คำบรรยาย',
                onPressed: () async {
                  Map<String, dynamic> map =
                      appController.currentUserModels.last.toMap();

                  map['description'] = textEditingController.text;

                  await AppService()
                      .processUpdateProfile(mapUserModel: map)
                      .whenComplete(
                    () {
                      Get.back();
                    },
                  );
                },
                type: GFButtonType.outline2x,
              )
            : SizedBox()),
        secondAction: Obx(() => WidgetButton(
            text: appController.display.value ? 'cancel' : 'ok',
            onPressed: () => Get.back())));
  }
}
