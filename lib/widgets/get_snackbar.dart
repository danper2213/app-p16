import 'package:app_p16/widgets/theme_custom.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

SnackbarController getSnack(
    String title, String msg, Color color, IconData icon) {
  return Get.snackbar(
    title,
    msg,
    backgroundColor: color,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 20,
    colorText: ColorCustom.whiteColor,
    dismissDirection: DismissDirection.horizontal,
    margin: const EdgeInsets.all(16),
    forwardAnimationCurve: Curves.easeOutBack,
    icon: Icon(
      icon,
      size: 30,
      color: Colors.white,
    ),
  );
}

//Get.snackbar('¡Producto exitosamente agregado!', 'El producto ha sido agregado correctamente',

//Get.snackbar('¡Ocurrio un error!', 'El producto no sido agregado ',