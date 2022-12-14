import 'package:app_p16/controllers/product_controller.dart';

import 'package:app_p16/models/product.dart';
import 'package:app_p16/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProduct extends StatelessWidget {
  final Product product;

  EditProduct({Key? key, required this.product}) : super(key: key);

  final _productController = Get.put<ProductController>(ProductController());

  final TextEditingController presentationController = TextEditingController();

  final TextEditingController costPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Editar Producto',
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 15,
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
    );
  }
}
