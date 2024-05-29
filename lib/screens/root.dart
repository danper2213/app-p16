import 'package:app_p16/controllers/auth_controller.dart';
import 'package:app_p16/screens/home.dart';
import 'package:app_p16/screens/signInOut/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    //print('Entre al build del root');
    return GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
            child: controller.userProfile != null ? const Home() : Login());
      },
    );
  }
}
