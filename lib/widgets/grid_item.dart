// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wiphuproj/models/user_model.dart';
import 'package:wiphuproj/utility/app_constant.dart';
import 'package:wiphuproj/widgets/widget_button.dart';
import 'package:wiphuproj/widgets/widget_image_network.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.proPhetUserModels,
    this.onPressed,
  }) : super(key: key);

  final UserModel proPhetUserModels;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child:  proPhetUserModels.urlImage!.isEmpty ? Image.asset(
              'images/avatar.png',
              fit: BoxFit.cover,
             )  : WidgetImageNetwork(src: proPhetUserModels.urlImage!, fit: BoxFit.cover) ,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child:  Text(
             proPhetUserModels.displayName,maxLines: 1,overflow:  TextOverflow.ellipsis,
              style: AppConstant().h3Style(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child:  Text(
              proPhetUserModels.slogan!, style: AppConstant().h3Style(color: AppConstant.mainColor),maxLines: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child:  Text(
              proPhetUserModels.description!, maxLines: 4,style: AppConstant().h3Style(),overflow: TextOverflow.ellipsis,
            ),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [


              WidgetButton(text: 'รายละเอียดเพิ่ม', onPressed: onPressed ?? (){}),

              SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
