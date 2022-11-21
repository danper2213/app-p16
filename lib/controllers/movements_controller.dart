import 'package:app_p16/models/movement.dart';
import 'package:app_p16/models/product.dart';

import 'package:app_p16/services/firestore.dart';
import 'package:app_p16/widgets/get_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovementsController extends GetxController {
  String selectedType = 'Entrada';
  final List<String> types = ["Entrada", "Salida"];
  var loadingMovement = false.obs;
  String selectedDate = '';

  var loading = true.obs;
  final movementList = <Movement>[].obs;
  final movementListByDate = <Movement>[].obs;

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
    print('${total < 0}');

    if (total < 0 && movement.type == 'Salida') {
      getSnack(
          '¡Error de movimiento!',
          'No es posible realizar el movimiento...',
          Colors.red,
          Icons.cancel_outlined);
    } else {
      loadingMovement.value = true;
      await Firestore().addMovement(movement, product);
      loadingMovement.value = false;
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
}
