import 'package:app_p16/controllers/movements_controller.dart';
import 'package:app_p16/models/product.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductoHistory extends StatefulWidget {
  const ProductoHistory({super.key, required this.product});
  final Product product;

  @override
  State<ProductoHistory> createState() => _ProductoHistoryState();
}

class _ProductoHistoryState extends State<ProductoHistory> {
  final MovementsController movementsController =
      Get.find<MovementsController>();
  var initialDate = '';
  var finalDate = '';

  @override
  void dispose() {
    movementsController.dateRegisterInital.value = '';
    movementsController.dateRegisterFinal.value = '';
    movementsController.movementListByProduct.value = [];

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  List<DataRow> _createRows() {
    List<DataRow> rows = [];
    for (var i = 0; i < movementsController.movementListByProduct.length; i++) {
      var m = movementsController.movementListByProduct[i];
      rows.add(DataRow(
          cells: [
            DataCell(Text(m.name)),
            DataCell(Text(m.quantity.toString())),
            DataCell(Text(m.type)),
            DataCell(Text(m.createdBy)),
            DataCell(Text(m.createdDate)),
          ],
          color: MaterialStateProperty.resolveWith((states) => i % 2 == 0
              ? ThemeCustom.primarySwatch.shade600
              : ThemeCustom.primarySwatch.shade800)));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product.name,
            style: TextStyleCustom.kanitFont(
              size: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Historico de movimientos',
                style: TextStyleCustom.kanitFont(
                  size: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: ThemeCustom.buildGradiente(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Fecha inicial',
                              style: TextStyleCustom.kanitFont(
                                size: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () => movementsController
                                  .showPickerDateinital(context),
                              icon: const Icon(Icons.calendar_month_rounded),
                            ),
                            Obx(() {
                              return Text(
                                movementsController.dateRegisterInital
                                    .toString(),
                                style: TextStyleCustom.kanitFont(size: 16),
                              );
                            })
                          ],
                        ),
                        //const Spacer(),
                        Column(
                          children: [
                            Text(
                              'Fecha Final',
                              style: TextStyleCustom.kanitFont(
                                size: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () => movementsController
                                  .showPickerDateFinal(context),
                              icon: const Icon(Icons.calendar_month_rounded),
                            ),
                            Obx(() {
                              return Text(
                                movementsController.dateRegisterFinal
                                    .toString(),
                                style: TextStyleCustom.kanitFont(size: 16),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                    Obx(
                      () {
                        return ElevatedButton.icon(
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(35, 35)),
                            ),
                            onPressed: (movementsController
                                        .dateRegisterFinal.isEmpty &&
                                    movementsController
                                        .dateRegisterInital.isEmpty)
                                ? null
                                : () {
                                    movementsController.fetchMovementsByProduct(
                                      widget.product.name,
                                      movementsController.dateRegisterInital
                                          .toString(),
                                      movementsController.dateRegisterFinal
                                          .toString(),
                                    );
                                  },
                            icon: const Icon(Icons.arrow_circle_right_rounded),
                            label: const Text('Aceptar'));
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(
                  () {
                    return movementsController.movementListByProduct.isEmpty
                        ? Column(
                            children: [
                              Text(
                                'No hay registros en este rango de fechas',
                                style: TextStyleCustom.kanitFont(size: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Lottie.asset(
                                'assets/document.json',
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ],
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                          //horizontalMargin: 0,
                                          columnSpacing: 30.0,
                                          headingRowColor:
                                              MaterialStateProperty.resolveWith(
                                            (states) => ColorCustom.marineBlue,
                                          ),
                                          border: TableBorder.all(
                                            color: ColorCustom.whiteColor,
                                            width: 1.5,
                                          ),
                                          dataTextStyle:
                                              TextStyleCustom.kanitFont(
                                                  size: 16),
                                          headingTextStyle:
                                              TextStyleCustom.kanitFont(
                                            size: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          columns: const [
                                            DataColumn(label: Text('Producto')),
                                            DataColumn(
                                                label: Text('Cantidad'),
                                                numeric: true),
                                            DataColumn(label: Text('Tipo')),
                                            DataColumn(
                                                label: Text('Realizado')),
                                            DataColumn(label: Text('Fecha')),
                                          ],
                                          rows: _createRows())),
                                ]),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
