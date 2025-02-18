import 'dart:io';

import 'package:get/get.dart';
import 'package:wiphuproj/models/user_model.dart';

class AppController extends GetxController {

  RxInt indexBody = 0.obs;

  RxList files = <File>[].obs;

  RxList nameFiles = <String>[].obs;

  RxList currentUserModels = <UserModel>[].obs;

  RxBool display = false.obs;

  RxList chooseDateTime = <DateTime>[].obs;
  
  
}