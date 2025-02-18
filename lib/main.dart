import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiphuproj/firebase_options.dart';
import 'package:wiphuproj/models/user_model.dart';
import 'package:wiphuproj/states/intro.dart';
import 'package:wiphuproj/states/main_home_prophet.dart';
import 'package:wiphuproj/states/main_home_user.dart';
import 'package:wiphuproj/utility/app_constant.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: '/intro', page: () => const Intro()),
  GetPage(name: '/mainHomeUser', page: () => const MainHomeUser()),
  GetPage(name: '/mainHomeProphet', page: () => const MainHomeProphet()),
];
String? initialRoute;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (value) async {
      var user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        //ยังไม่ได้login
        initialRoute = '/intro';
        runApp(const MyApp());
      } else {
        //login แล้ว
        var result = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();
        if (result.data() == null) {
          //ไม่มี uid นี้ในฐานข้อมูล
          initialRoute = '/intro';
          runApp(const MyApp());
        } else {
          UserModel userModel = UserModel.fromMap(result.data()!);

          initialRoute = userModel.user! ? '/mainHomeUser' : '/mainHomeProphet';

          runApp(const MyApp());
        }
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      theme:
          ThemeData(useMaterial3: true, colorSchemeSeed: AppConstant.mainColor),
      // home: const Intro(),
      getPages: getPages,
      initialRoute: initialRoute,
    );
  }
}
