import 'package:app_p16/screens/product/add_product.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Modal extends StatelessWidget {
  Modal({Key? key}) : super(key: key);
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Agregar producto'),
            //tileColor: Color.fromRGBO(0, 150, 199, 0.3),
            textColor: Colors.white,
            onTap: () {
              Get.to(() => AddProduct());
            },
          ),
          ListTile(
            leading: const Icon(Icons.close_sharp),
            title: const Text('Salir'),
            //tileColor: Color.fromRGBO(0, 150, 199, 0.3),
            textColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
