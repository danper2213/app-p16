import 'package:app_p16/controllers/product_controller.dart';

import 'package:app_p16/models/product.dart';
import 'package:app_p16/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProduct extends StatelessWidget {
  final Product product;
  final _productController = Get.put<ProductController>(ProductController());
  final TextEditingController presentationController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();

  EditProduct({Key? key, required this.product}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Editar Producto',
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormFieldCustom(
                labelText: 'Presentación',
                controller: presentationController,
                icon: Icons.inventory_2,
                typeInput: TextInputType.emailAddress,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Presentación: ${product.category}',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      textStyle: const TextStyle(fontStyle: FontStyle.italic)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      'Precio costo',
                      style: TextStyle(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16.0)),
                    prefixIcon: const Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.white,
                    )),
                controller: costPriceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Precio costo: ${product.costPrice}',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      textStyle: const TextStyle(fontStyle: FontStyle.italic)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton.icon(
                    onPressed: (() {
                      _productController.updateProduct(
                          product,
                          presentationController.text,
                          int.parse(costPriceController.text));
                    }),
                    icon: const Icon(Icons.move_down_rounded),
                    label: Text(
                      'Aceptar',
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
