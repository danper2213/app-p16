import 'package:app_p16/controllers/product_controller.dart';
import 'package:app_p16/screens/product/detail_product.dart';
import 'package:app_p16/widgets/theme_custom.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProductList extends StatelessWidget {
  final productController = Get.put(ProductController());
  final TextEditingController searchController = TextEditingController();

  ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Total Productos',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300)),
                Obx((() => Text(productController.totalProducts.toString(),
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800))))
              ],
            ),
            Column(
              children: [
                Text('Saldo total',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300)),
                Obx((() => Text('\$ ${productController.totalP}',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800))))
              ],
            ),
          ],
        ),
        height: 80.0,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF0575E6),
              Color(0xFF021B79),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        autofocus: false,
        onChanged: (value) => productController.filterProduct(value),
        decoration: InputDecoration(
            label: const Text(
              'Buscar Producto',
              style: TextStyle(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(16.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(16.0)),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
            )),
        controller: searchController,
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(
        height: 20,
      ),
      ListProduct(productController: productController),
    ]);
    //
  }
}

class ListProduct extends StatelessWidget {
  const ListProduct({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    print('list');
    return Expanded(
      child: Obx(() => productController.foundProducts.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset(
                  'assets/not_found.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ],
            )
          : ListView.builder(
              itemCount: productController.foundProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => Get.to(() => DetailProduct(
                        product: productController.foundProducts[index])),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Hero(
                        tag: productController.foundProducts[index],
                        child: Card(
                          color: const Color.fromRGBO(3, 4, 94, 0 - 5),
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(5, 117, 230, 100),
                                      Color.fromRGBO(2, 27, 121, 100),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              leading: Image.network(
                                productController.foundProducts[index].urlImage,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(
                                  productController.foundProducts[index].name,
                                  style: GoogleFonts.roboto(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800)),
                              subtitle: Text(
                                  'Cantidad: ' +
                                      productController
                                          .foundProducts[index].quantity
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400)),
                              tileColor: Colors.transparent,
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: ColorCustom.marineBlue,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
    );
  }
}
