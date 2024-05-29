import 'package:app_p16/screens/root.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'controllers/home_binding.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAKP-s8NiQVrNm_nYxPqAV6_nHyT9UJXMM',
    appId: 'app-p16',
    messagingSenderId: 'app-p16',
    projectId: 'app-p16',
    storageBucket: 'app-p16.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: ThemeCustom.primarySwatch),
    );
    return GetMaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeCustom.blueTheme,
      initialBinding: BindingControllers(),
      home: const Root(),
    );
  }
}
