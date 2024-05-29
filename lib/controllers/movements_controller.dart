import 'package:app_p16/models/movement.dart';
import 'package:app_p16/models/product.dart';

import 'package:app_p16/services/firestore.dart';
import 'package:app_p16/widgets/get_snackbar.dart';
import 'package:app_p16/widgets/theme_custom.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MovementsController extends GetxController {
  String selectedType = 'Entrada';
  final List<String> types = ["Entrada", "Salida"];

  RxString formattedDate = ''.obs;

  var loadingMovement = false.obs;
  String selectedDate = '';
  RxString dateRegisterInital = ''.obs;
  RxString dateRegisterFinal = ''.obs;

  var loading = true.obs;
  final movementList = <Movement>[].obs;
  final movementListByDate = <Movement>[].obs;
  final movementListByProduct = <Movement>[].obs;

  get totalMovementsByDate => movementListByDate.length;

  @override
  void onInit() {
    fetchAllMovements();

    super.onInit();
  }

  void onClickRadioButton(value) {
    selectedType = value;

    update();
  }

  void addMovement(Movement movement, Product product) async {
    //print('${movement.quantity} y ${product.quantity}');
    final total = product.quantity - movement.quantity;

    if (total < 0 && movement.type == 'Salida' || movement.quantity == 0) {
      getSnack(
        '¡Error de movimiento!',
        'No es posible realizar el movimiento...',
        Colors.redAccent,
        Icons.cancel_outlined,
      );
    } else {
      loadingMovement.value = true;
      await Firestore().addMovement(movement, product);
      loadingMovement.value = false;
    }
  }

  String getDateFormat() {
    DateTime now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }

  void showPickerDateinital(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
        confirmText: 'Aceptar',
        cancelText: 'Cancelar',
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorCustom.marineBlue,
                  onPrimary: Colors.white,
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    textStyle: TextStyleCustom.kanitFont(),
                    // button text color
                  ),
                ),
              ),
              child: child!);
        });
    if (selected != null) {
      dateRegisterInital.value =
          DateFormat('dd/MM/yyyy').format(selected).toString();
    }
  }

  void showPickerDateFinal(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        locale: const Locale("es", "ES"),
        confirmText: 'Aceptar',
        cancelText: 'Cancelar',
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorCustom.marineBlue,
                  onPrimary: Colors.white,
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    textStyle: TextStyleCustom.kanitFont(),
                    // button text color
                  ),
                ),
              ),
              child: child!);
        },
        lastDate: DateTime(2050));

    if (selected != null) {
      dateRegisterFinal.value =
          DateFormat('dd/MM/yyyy').format(selected).toString();
    }
  }

  void fetchAllMovements() async {
    movementList.bindStream(Firestore().getAllMovements());
    movementListByDate.value = movementList;
  }

  void fetchMovementsByDate(String date) {
    movementList.bindStream(Firestore().getAllMovementsByDate(date));
    movementListByDate.value = movementList;
  }

  void fetchMovementsByProduct(
      String name, String initalDate, String finalDate) {
    movementListByProduct.bindStream(Firestore().getAllMovementsByProduct(
      name,
      initalDate,
      finalDate,
    ));
    //movementListByProduct.value = movementList;
  }
}
