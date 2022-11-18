import 'package:app_p16/screens/root.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/home_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeCustom.blueTheme,
      initialBinding: BindingControllers(),
      home: const Root(),
      // darkTheme: ThemeData(
      //   scaffoldBackgroundColor: const Color.fromRGBO(3, 4, 94, 1),
      //   textTheme: GoogleFonts.robotoTextTheme(),
      //   hintColor: Colors.white,
      //   colorScheme: const ColorScheme.dark(
      //     primary: Color.fromRGBO(0, 150, 199, 1),
      //     onPrimary: Colors.white,
      //   ),
      // ),
    );
  }
}
