// ignore_for_file: must_be_immutable

import 'package:app_p16/controllers/movements_controller.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Movements extends StatefulWidget {
  const Movements({super.key});

  @override
  State<Movements> createState() => _MovementsState();
}

class _MovementsState extends State<Movements> {
  final MovementsController movementsController =
      Get.put(MovementsController());

  late String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Movimientos',
                style: TextStyleCustom.kanitFont(
                  size: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  movementsController.formattedDate.value,
                  textAlign: TextAlign.right,
                  style: TextStyleCustom.kanitFont(size: 18),
                ),
              ),
              IconButton(
                  alignment: Alignment.centerRight,
                  splashRadius: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: const Icon(Icons.calendar_month_rounded))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: Obx(
            () => Text(
              'Total movimientos ${movementsController.totalMovementsByDate}',
              style: TextStyleCustom.kanitFont(
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Obx(() => movementsController.movementListByDate.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'No existen registros del dia: ${movementsController.formattedDate}',
                            style: TextStyleCustom.kanitFont(size: 18)),
                        Lottie.asset(
                          'assets/not_found.json',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: movementsController.movementListByDate.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTileCustom(
                        createdDate: movementsController
                            .movementListByDate[index].createdDate
                            .toString(),
                        quantity: movementsController
                            .movementListByDate[index].quantity
                            .toString(),
                        product:
                            movementsController.movementListByDate[index].name,
                        createdBy: movementsController
                            .movementListByDate[index].createdBy,
                        type:
                            movementsController.movementListByDate[index].type,
                      );
                    },
                  )))
      ],
    );
  }

  _selectDate(BuildContext context) async {
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
                  ),
                ),
              ),
              child: child!);
        });
    if (selected != null) {
      movementsController.formattedDate.value =
          DateFormat('dd/MM/yyyy').format(selected).toString();
      movementsController
          .fetchMovementsByDate(movementsController.formattedDate.value);
    }
  }
}

class ListTileCustom extends StatelessWidget {
  final String createdDate;
  final String quantity;
  final String product;
  final String createdBy;
  final String type;

  const ListTileCustom(
      {super.key,
      required this.createdDate,
      required this.quantity,
      required this.product,
      required this.createdBy,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.transparent,
      child: Container(
        decoration: ThemeCustom.buildGradiente(
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(
            type == 'Entrada'
                ? Icons.arrow_circle_right_rounded
                : Icons.arrow_circle_left_rounded,
            color: type == 'Entrada' ? Colors.greenAccent : Colors.redAccent,
            size: 40,
          ),
          title: Text(
            '$quantity $product',
            overflow: TextOverflow.ellipsis,
            style: TextStyleCustom.kanitFont(
              fontWeight: FontWeight.w600,
              size: 18,
            ),
          ),
          subtitle: Text(
            createdBy,
            style: TextStyleCustom.kanitFont(
              size: 16,
            ),
          ),
          trailing: Text(
            createdDate,
            style: TextStyleCustom.kanitFont(
              fontWeight: FontWeight.w600,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
