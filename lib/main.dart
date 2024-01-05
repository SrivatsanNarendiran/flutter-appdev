import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:university_buddy/auth_controller.dart';
import 'package:university_buddy/login_page.dart';
import 'package:university_buddy/signup_page.dart';
import 'package:university_buddy/splash_screen.dart';
import 'package:university_buddy/welcome_page.dart';
import 'package:university_buddy/qr_code.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //tell flutter to wait for binding and authentication control
  await Firebase.initializeApp()
      .then((value) => Get.put(AuthController())); //adds dependency injectino
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}
