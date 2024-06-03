import 'package:app_p16/controllers/auth_controller.dart';
import 'package:app_p16/controllers/movements_controller.dart';
import 'package:app_p16/models/movement.dart';
import 'package:app_p16/models/product.dart';
import 'package:app_p16/widgets/get_date_format.dart';
import 'package:app_p16/widgets/theme_custom.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMovement extends StatefulWidget {
  const AddMovement({super.key, required this.product});

  final Product product;

  @override
  State<AddMovement> createState() => _AddMovementState();
}

class _AddMovementState extends State<AddMovement> {
  final _authController = Get.put<AuthController>(AuthController());

  final TextEditingController quantityController = TextEditingController();

  final movementsController =
      Get.put<MovementsController>(MovementsController());

  final String selectedType = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Crear moviento',
            style: TextStyleCustom.kanitFont(
                size: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Selecciona el tipo de movimiento',
            style: TextStyleCustom.kanitFont(size: 16),
          ),
          GetBuilder<MovementsController>(builder: (controller) {
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Radio(
                      fillColor: WidgetStateColor.resolveWith(
                          (states) => const Color.fromRGBO(0, 150, 199, 1)),
                      groupValue: controller.selectedType,
                      value: controller.types[0],
                      onChanged: (value) {
                        controller.onClickRadioButton(value);
                      },
                    ),
                    title: Text(
                      'Entrada',
                      style: TextStyleCustom.kanitFont(size: 16),
                    ),
                    textColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Radio(
                      fillColor: WidgetStateColor.resolveWith(
                          (states) => const Color.fromRGBO(0, 150, 199, 1)),
                      groupValue: controller.selectedType,
                      value: controller.types[1],
                      onChanged: (value) {
                        controller.onClickRadioButton(value);
                      },
                    ),
                    title: Text(
                      'Salida',
                      style: TextStyleCustom.kanitFont(size: 16),
                    ),
                    textColor: Colors.white,
                  ),
                ),
              ],
            );
          }),
          TextFormField(
            decoration: const InputDecoration(
                label: Text(
                  'Cantidad',
                ),
                prefixIcon: Icon(
                  Icons.apps_rounded,
                  color: Colors.white,
                )),
            controller: quantityController,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: TextStyleCustom.kanitFont(),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Stock: ${widget.product.quantity}',
            style: GoogleFonts.kanit(
                color: Colors.white,
                fontSize: 14,
                textStyle: const TextStyle(fontStyle: FontStyle.italic)),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Obx((() => ElevatedButton.icon(
                onPressed: (() {
                  movementsController.addMovement(
                      Movement(
                          name: widget.product.name,
                          type: movementsController.selectedType,
                          quantity: quantityController.text.isEmpty
                              ? 0
                              : int.parse(quantityController.text),
                          createdBy: _authController.userProfile!.displayName!
                              .toString(),
                          createdDate: getDateFormat()),
                      widget.product);
                  quantityController.clear();
                }),
                icon: movementsController.loadingMovement.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.save_alt_rounded),
                label: Text(
                  movementsController.loadingMovement.value
                      ? 'Cargando'
                      : 'Aceptar',
                  style: TextStyleCustom.kanitFont(
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )))),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
