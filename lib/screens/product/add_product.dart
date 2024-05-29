import 'dart:io';

import 'package:app_p16/controllers/product_controller.dart';
import 'package:app_p16/models/product.dart';

import 'package:app_p16/widgets/theme_custom.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productController = Get.put(ProductController());

  final TextEditingController nameController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  final TextEditingController costPriceController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(3, 4, 94, 1),
          elevation: 0,
          title: Image.asset(
            'assets/logotipo.png',
            width: 45,
            height: 45,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agregar Producto',
                    style: TextStyleCustom.kanitFont(
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onDoubleTap: () {
                        //productController.selectFile();
                        productController.cropImage();
                      },
                      child: GetBuilder<ProductController>(
                        builder: (controller) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorCustom.marineBlue, width: 2),
                                borderRadius: BorderRadius.circular(16.0)),
                            height: 150,
                            width: 200,
                            child: controller.imageFile != null
                                ? Image.file(
                                    File(controller.imageFile!.path),
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    'assets/image.png',
                                    fit: BoxFit.cover,
                                    color: Colors.white,
                                  )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text(
                          'Nombre',
                          style: TextStyleCustom.kanitFont(),
                        ),
                        prefixIcon: const Icon(
                          Icons.label,
                          color: Colors.white,
                        )),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    style: TextStyleCustom.kanitFont(),
                    textInputAction: TextInputAction.next,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }

                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text('Precio costo',
                            style: TextStyleCustom.kanitFont()),
                        prefixIcon: const Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.white,
                        )),
                    controller: costPriceController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    style: TextStyleCustom.kanitFont(),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }

                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text('Cantidad',
                            style: TextStyleCustom.kanitFont()),
                        prefixIcon: const Icon(
                          Icons.numbers_outlined,
                          color: Colors.white,
                        )),
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    style: TextStyleCustom.kanitFont(),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }

                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text('Presentación',
                            style: TextStyleCustom.kanitFont()),
                        prefixIcon: const Icon(
                          Icons.inventory_2,
                          color: Colors.white,
                        )),
                    controller: categoryController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    style: TextStyleCustom.kanitFont(),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'No puede estar vacio';
                      }

                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Obx((() => ElevatedButton.icon(
                          icon: productController.loadingAdd.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Icon(Icons.save_alt_rounded),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              productController.loadingAdd.value
                                  ? null
                                  : productController.addProduct(Product(
                                      name: nameController.text,
                                      category: categoryController.text,
                                      costPrice:
                                          int.parse(costPriceController.text),
                                      quantity:
                                          int.parse(quantityController.text),
                                      urlImage: ''));
                              nameController.clear();
                              categoryController.clear();
                              costPriceController.clear();
                              quantityController.clear();
                              productController.imageFile = null;
                              productController.update();
                            }
                          },
                          label: Text(
                            productController.loadingAdd.value
                                ? 'Agregando'
                                : 'Agregar',
                            style: TextStyleCustom.kanitFont(size: 20),
                          ),
                        ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
