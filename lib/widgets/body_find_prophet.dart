import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiphuproj/widgets/widget_form.dart';

import 'grid_item.dart';

class BodyFindProphet extends StatelessWidget {
  const BodyFindProphet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}