import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCustom {
  ThemeCustom._();
  static const MaterialColor primarySwatch =
      MaterialColor(_colorPrimaryValue, <int, Color>{
    50: Color(0xFFE0E0ED),
    100: Color(0xFFB3B3D1),
    200: Color(0xFF8080B3),
    300: Color(0xFF4D4D94),
    400: Color(0xFF26267D),
    500: Color(_colorPrimaryValue),
    600: Color(0xFF00005E),
    700: Color(0xFF000053),
    800: Color(0xFF000049),
    900: Color(0xFF000038),
  });
  static const int _colorPrimaryValue = 0xFF000066;

  static ThemeData blueTheme = ThemeData(
      textTheme: GoogleFonts.robotoTextTheme(),
      primarySwatch: primarySwatch,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primarySwatch,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorCustom.marineBlue,
        foregroundColor: ColorCustom.whiteColor,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primarySwatch,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: ColorCustom.whiteColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: ColorCustom.whiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: ColorCustom.marineBlue),
          ),
          labelStyle: TextStyle(
            color: ColorCustom.whiteColor,
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(50, 80)),
        textStyle: MaterialStateProperty.all(TextStyleCustom.regular20()),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return ColorCustom.marineBlue.withOpacity(0.5);
          }
          return ColorCustom.marineBlue;
        }),
      )));

  static buildGradiente() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF0575E6),
          Color(0xFF021B79),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.all(Radius.circular(8.0)));
  }
}

class ColorCustom {
  ColorCustom._();

  static const whiteColor = Colors.white;
  static const marineBlue = Color.fromRGBO(0, 162, 254, 1);
}

class TextStyleCustom {
  TextStyleCustom._();

  static TextStyle regular16({Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.roboto(
      fontSize: 16.0,
      fontWeight: fontWeight,
      color: color ?? ColorCustom.whiteColor,
    );
  }

  static TextStyle regular18({Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.roboto(
      color: color ?? ColorCustom.whiteColor,
      fontSize: 18,
      fontWeight: fontWeight,
    );
  }

  static TextStyle regular20({Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.roboto(
      fontSize: 20.0,
      fontWeight: fontWeight,
      color: color ?? ColorCustom.whiteColor,
    );
  }
}
