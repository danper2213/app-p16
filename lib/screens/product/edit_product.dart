import 'package:app_p16/controllers/product_controller.dart';

import 'package:app_p16/models/product.dart';
import 'package:app_p16/widgets/text_custom.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  const EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _productController = Get.put<ProductController>(ProductController());

  final TextEditingController nameController = TextEditingController();

  final TextEditingController presentationController = TextEditingController();

  final TextEditingController costPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Editar Producto',
            style: TextStyleCustom.kanitFont(
              size: 25,
              fontWeight: FontWeight.bold,
            ),
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
            labelText: 'Nombre',
            controller: nameController,
            icon: Icons.abc_rounded,
            typeInput: TextInputType.text,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nombre: ${widget.product.name}',
              style: TextStyleCustom.kanitFont(
                fontStyle: FontStyle.italic,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
              'Presentación: ${widget.product.category}',
              style: TextStyleCustom.kanitFont(
                fontStyle: FontStyle.italic,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldCustom(
            labelText: 'Precio costo',
            controller: costPriceController,
            icon: Icons.monetization_on_outlined,
            typeInput: TextInputType.number,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Precio costo: ${widget.product.costPrice}',
              style: TextStyleCustom.kanitFont(
                fontStyle: FontStyle.italic,
                size: 15,
              ),
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
                  final presentation = (presentationController.text.isEmpty)
                      ? widget.product.category
                      : presentationController.text;
                  final cost = (costPriceController.text.isEmpty)
                      ? int.parse(widget.product.costPrice.toString())
                      : int.parse(costPriceController.text);
                  final name = (nameController.text.isEmpty)
                      ? widget.product.name
                      : nameController.text;

                  _productController.updateProduct(
                      widget.product, name, presentation, cost);
                }),
                icon: _productController.editProduct.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.move_down_rounded),
                label: Text(
                  _productController.editProduct.value ? 'Cargando' : 'Aceptar',
                  style: TextStyleCustom.kanitFont(
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
