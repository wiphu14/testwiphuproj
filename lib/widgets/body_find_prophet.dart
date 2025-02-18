import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiphuproj/models/user_model.dart';
import 'package:wiphuproj/states/detail_prophet.dart';
import 'package:wiphuproj/utility/app_service.dart';
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
          FutureBuilder(
            future: AppService().readAllProphet(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UserModel> proPhetUserModels = snapshot.data!;

                //ทดสอบเพิ่มจำนวน หมอดู
                for (var i = 0; i < 20; i++) {
                  proPhetUserModels.add(proPhetUserModels.last);
                }

                return Positioned(
                    top: 80,
                    child: SizedBox(
                        width: Get.width,
                        height: Get.height - 80,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 4.0,
                          ),
                          itemCount: proPhetUserModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GridItem(
                              proPhetUserModels: proPhetUserModels[index],

                              onPressed: () {
                                Get.to(DetailProphet(proPhetUserModel: proPhetUserModels[index]));
                              },
                            );
                          },
                        )));
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
