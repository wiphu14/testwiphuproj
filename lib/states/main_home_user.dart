import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wiphuproj/widgets/grid_item.dart';
import 'package:wiphuproj/widgets/widget_form.dart';
import 'package:wiphuproj/widgets/widget_sign_out.dart';

class MainHomeUser extends StatefulWidget {
  const MainHomeUser({super.key});

  @override
  State<MainHomeUser> createState() => _MainHomeUserState();
}

class _MainHomeUserState extends State<MainHomeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("หมอดู แม่นๆ"),
        actions: [
          WidgetSignOut(),
          SizedBox(width: 16),
        ],
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            WidgetFrom(
                hintText: 'ค้นหา:', suffixIcon: Icon(Icons.search), radius: 4),
            Positioned(top: 80,
              child: SizedBox(
                width: Get.width,
                height: Get.height - 80,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const GridItem();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
