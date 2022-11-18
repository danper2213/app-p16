// ignore_for_file: must_be_immutable

import 'package:app_p16/controllers/movements_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Movements extends StatelessWidget {
  final MovementsController movementsController =
      Get.put(MovementsController());
  late String formattedDate = '';
  Movements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Movimientos',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  _selectDate(context);
                },
                icon: const Icon(Icons.calendar_month_rounded))
          ],
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
                        Text('No existen registros del dia: $formattedDate',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18.0,
                            )),
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
                        createdDate:
                            movementsController.movementList[index].createdDate,
                        quantity: movementsController
                            .movementList[index].quantity
                            .toString(),
                        product: movementsController.movementList[index].name,
                        createdBy:
                            movementsController.movementList[index].createdBy,
                        type: movementsController.movementList[index].type,
                      );
                    },
                  )))
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));
    if (selected != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(selected).toString();

      movementsController.fetchMovementsByDate(formattedDate);
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
      {Key? key,
      required this.createdDate,
      required this.quantity,
      required this.product,
      required this.createdBy,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(5, 117, 230, 100),
              Color.fromRGBO(2, 27, 121, 100),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.all(Radius.circular(8))),
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
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            createdBy,
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
          trailing: Text(
            createdDate,
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
