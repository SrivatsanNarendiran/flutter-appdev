import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:university_buddy/login_page.dart';
import 'package:university_buddy/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//auth controller has to be accessible from all the pages, signin, sign-up, login page

class AuthController extends GetxController {
  //AuthController.instance... to access AuthController and it's fields in other files in future
  static AuthController instance =
      Get.find(); //static means same instance available throughout
  late Rx<User?> _user; //email, password, name...
  FirebaseAuth auth = FirebaseAuth.instance; //access properties from firebase
  @override
  void onReady() {
    super.onReady(); //initialization
    _user = Rx<User?>(auth.currentUser); //casting current user to be a RX user
    _user.bindStream(auth
        .userChanges()); //app will be notified of the changes the user does like loginIn,logOut
    //how to notify user has logged In
    ever(_user, _initialScreen);

    //ever(listener, callback function )
  }

  //? to indicate that there may or maynot be a user
  _initialScreen(User? user) {
    if (user == null) {
      print("Login Page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => WelcomePage(email: user.email!));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email,
          password:
              password); // await and async are asyncronous which wait for the result and then execute the rest of the part
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account Creation Failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText:
              Text(e.toString(), style: TextStyle(color: Colors.white)));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password:
              password); // await and async are asyncronous which wait for the result and then execute the rest of the part
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login Failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText:
              Text(e.toString(), style: TextStyle(color: Colors.white)));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
