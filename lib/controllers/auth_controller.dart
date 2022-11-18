import 'package:app_p16/screens/signInOut/login.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var displayName = '';
  var isSignedIn = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;

  void signUp(String name, String email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        auth.currentUser!.updateDisplayName(name);
      });
      Get.to(() => Login());
    } catch (e) {
      Get.snackbar('Usuario', 'Mensaje usuario',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Error creando cuenta',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, String password) async {
    isSignedIn.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      update();
    } catch (e) {
      Get.snackbar('About Login', 'Login message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Login Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
    isSignedIn.value = false;
  }

  void logOut() async {
    try {
      await auth.signOut();
      update();
    } catch (e) {
      Get.snackbar('About Login', 'Login message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Log out Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }
}
