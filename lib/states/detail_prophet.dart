// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:wiphuproj/models/user_model.dart';
import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_controller.dart';
import 'package:wiphuproj/utility/app_dialog.dart';
import 'package:wiphuproj/utility/app_service.dart';
import 'package:wiphuproj/widgets/widget_avatar.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_form.dart';
import 'package:wiphuproj/widgets/widget_image.dart';
import 'package:wiphuproj/widgets/widget_image_network.dart';

class DetailProphet extends StatefulWidget {
  const DetailProphet({
    Key? key,
    required this.proPhetUserModel,
  }) : super(key: key);

  final UserModel proPhetUserModel;

  @override
  State<DetailProphet> createState() => _DetailProphetState();
}

class _DetailProphetState extends State<DetailProphet> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      elementTop(),
                      SizedBox(height: 16),
                      Text('Skill'),
                      SizedBox(height: 16),
                      nameAndSlogan(),
                      SizedBox(height: 16),
                      displayDescrip(),
                      SizedBox(height: 16),
                      
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Row nameAndSlogan() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(padding: EdgeInsets.all(16),
                          width: Get.width * 0.75,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              displayName(),
                              SizedBox(height: 16),
                              displaySlogan(),
                            ],
                          ),
                        ),
                      ],
                    );
  }

  Widget elementTop() {
    return SizedBox(
      width: Get.width,
      height: Get.height / 2 + 60,
      child: Stack(
        children: [
          Container(
              width: Get.width,
              height: Get.height / 2,
              decoration: BoxDecoration(border: Border.all()),
              child: widget.proPhetUserModel.urlImage!.isEmpty
                  ? Widgetimage(name: 'images/avatar.png')
                  : WidgetImageNetwork(
                      src: widget.proPhetUserModel.urlImage!,
                      fit: BoxFit.cover,
                    )),

          //small image
          Positioned(
              top: Get.height / 2 - 60,
              left: 16,
              child: WidgetAvater(
                  backgroundImage: widget.proPhetUserModel.urlImage!.isEmpty
                      ? AssetImage('images/avatar.png')
                      : NetworkImage(widget.proPhetUserModel.urlImage!),
                  radius: 60)),
        ],
      ),
    );
  }

  Widget displayDescrip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.75,
          child: Text(
              widget.proPhetUserModel.description!.isEmpty
                  ? 'Non Description'
                  : widget.proPhetUserModel.description!,
              style: AppConstant()
                  .h2Style(fontWeight: FontWeight.normal, fontSize: 16)),
        ),
      ],
    );
  }

  Widget displaySlogan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            widget.proPhetUserModel.slogan!.isEmpty
                ? 'ไม่มี สโลแกน ?'
                : widget.proPhetUserModel.slogan!,
            style: AppConstant()
                .h2Style(fontWeight: FontWeight.normal, fontSize: 16)),
      ],
    );
  }

  Widget displayName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.6,
          child: Text(
            widget.proPhetUserModel.displayName,
            style: AppConstant().h2Style(),
          ),
        ),
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
