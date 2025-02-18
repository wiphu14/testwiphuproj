import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/utility/app_controller.dart';
import 'package:wiphuproj/utility/app_service.dart';

import 'package:wiphuproj/widgets/body_find_prophet.dart';
import 'package:wiphuproj/widgets/body_user_profile.dart';
import 'package:wiphuproj/widgets/widget_sign_out.dart';

class MainHomeUser extends StatefulWidget {
  const MainHomeUser({super.key});

  @override
  State<MainHomeUser> createState() => _MainHomeUserState();
}

class _MainHomeUserState extends State<MainHomeUser> {
  var titles = <String>[
    'หาหมอดู',
    'รายการหมอดู',
    'ดูดวงฟรี',
    'โปรไฟล์',
  ];

  var iconDatas = <IconData>[
    Icons.assistant_navigation,
    Icons.comment_outlined,
    Icons.cruelty_free_outlined,
    Icons.person_outlined,
  ];

  var bodys = <Widget>[
    BodyFindProphet(),
    Text('รายการดูดวง'),
    Text('ดูดวงฟรี'),
    BodyUserProfile(),
  ];

  AppController appController = Get.put(AppController());

  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();

    if (appController.currentUserModels.isEmpty) {
      AppService().findCurrentUserModel();
    }

    for (var i = 0; i < bodys.length; i++) {
      items.add(
          BottomNavigationBarItem(icon: Icon(iconDatas[i]), label: titles[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(titles[appController.indexBody.value], style: AppConstant().h2Style(),),
            actions: [
              WidgetSignOut(),
              SizedBox(width: 16),
            ],
          ),
          body: bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appController.indexBody.value,
            items: items,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppConstant.mainColor,
            unselectedItemColor: GFColors.LIGHT,
            onTap: (value) {
              appController.indexBody.value = value;
            },
          ),
        ));
  }
}
