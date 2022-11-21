import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_p16/controllers/product_controller.dart';
import 'package:app_p16/screens/product/detail_product.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      const SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Total Productos',
                    style: TextStyleCustom.regular16(
                      fontWeight: FontWeight.w300,
                    )),
                Obx((() => Text(productController.totalProducts.toString(),
                    style: TextStyleCustom.regular20(
                      fontWeight: FontWeight.bold,
                    ))))
              ],
            ),
            Column(
              children: [
                Text('Saldo total',
                    style: TextStyleCustom.regular16(
                      fontWeight: FontWeight.w300,
                    )),
                Obx((() => Text('\$ ${productController.totalP}',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800))))
              ],
            ),
          ],
        ),
        height: 70.0,
        decoration: ThemeCustom.buildGradiente(),
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 20,
        child: DefaultTextStyle(
          style: TextStyleCustom.regular18(),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              RotateAnimatedText('¡Realiza movimientos de productos!'),
              RotateAnimatedText('¡Consulta los movimientos!'),
              RotateAnimatedText('¡Genera reportes de producto!'),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        autofocus: false,
        onChanged: (value) => productController.filterProduct(value),
        decoration: InputDecoration(
            label: AnimatedTextKit(animatedTexts: [
              TyperAnimatedText(
                'Buscar producto',
                speed: const Duration(milliseconds: 100),
              )
            ]),
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
    print('List products');
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
                              leading: CachedNetworkImage(
                                height: 50,
                                width: 50,
                                placeholder: (context, url) => Lottie.asset(
                                  'assets/downloading.json',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                                imageUrl: productController
                                    .foundProducts[index].urlImage,
                              ),

                              /* Image.network(
                                productController.foundProducts[index].urlImage,
                                height: 50,
                                width: 50,
                              ), */
                              title: Text(
                                  productController.foundProducts[index].name,
                                  style: GoogleFonts.roboto(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800)),
                              subtitle: (productController
                                          .foundProducts[index].quantity ==
                                      0)
                                  ? Text(
                                      'Producto sin existencia',
                                      style: TextStyleCustom.regular16(
                                          color: Colors.redAccent),
                                    )
                                  : Text(
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
                                Icons.arrow_circle_right_sharp,
                                color: ColorCustom.marineBlue,
                                size: 25.0,
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
