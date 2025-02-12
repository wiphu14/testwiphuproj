import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiphuproj/utility/app_controller.dart';
import 'package:wiphuproj/utility/app_service.dart';
import 'package:wiphuproj/widgets/body_income_prophet.dart';
import 'package:wiphuproj/widgets/body_profile_prophet.dart';
import 'package:wiphuproj/widgets/body_work_prophet.dart';
import 'package:wiphuproj/widgets/widget_sign_out.dart';

class MainHomeProphet extends StatefulWidget {
  const MainHomeProphet({super.key});

  @override
  State<MainHomeProphet> createState() => _MainHomeProphetState();
}

class _MainHomeProphetState extends State<MainHomeProphet> {
  AppController appController = Get.put(AppController());

  var widgets = <Widget>[
    const BodyWorkProphet(),
    const BodyincomeProphet(),
    const BodyProfileProphet(),
  ];

  var title = <String>[
    'ลิสงาน',
    'รายงาน',
    'โปรไฟร์',
  ];

  var iconDatas = <IconData>[
    Icons.work,
    Icons.money,
    Icons.person,
  ];

  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();

  AppService().findCurrentUserModel();

    for (var i = 0; i < widgets.length; i++) {
      items.add(
          BottomNavigationBarItem(icon: Icon(iconDatas[i]), label: title[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('Main Home(หมอดู)'),
            actions: [WidgetSignOut()],
          ),
          body: widgets[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            onTap: (value) {


              appController.indexBody.value = value;



            },
          ),
        ));
  }
}
