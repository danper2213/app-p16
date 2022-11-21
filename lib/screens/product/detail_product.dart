import 'package:app_p16/controllers/movements_controller.dart';
import 'package:app_p16/controllers/product_controller.dart';
import 'package:app_p16/models/product.dart';
import 'package:app_p16/screens/home.dart';
import 'package:app_p16/screens/movements/add_movement.dart';
import 'package:app_p16/screens/product/edit_product.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DetailProduct extends StatelessWidget {
  final Product product;
  DetailProduct({Key? key, required this.product}) : super(key: key);

  final productController = Get.put(ProductController());

  final movementController = Get.put(MovementsController());

  @override
  Widget build(BuildContext context) {
    /*  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
      overlays: [SystemUiOverlay.top],
    ); */
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                type: MaterialType.transparency,
                child: Hero(
                    tag: product,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF0575E6),
                                Color(0xFF021B79),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100.0))),
                      width: double.infinity,
                      height: 350,
                      child: Stack(
                        children: [
                          Positioned(
                            child: GestureDetector(
                              onTap: (() => Get.offAll(() => const Home())),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 24,
                              ),
                            ),
                            left: 20,
                            top: 20,
                          ),
                          Positioned(
                            //Edit product
                            child: GestureDetector(
                              child: Obx(() {
                                return productController.editProduct.value
                                    ? const Icon(
                                        Icons.edit,
                                        size: 24,
                                      )
                                    : const Icon(
                                        Icons.done_outline_rounded,
                                        size: 24,
                                      );
                              }),
                              onTap: () {
                                productController.changeEditStatus(
                                    !productController.editProduct.value);
                              },
                            ),

                            /* GestureDetector(
                              onTap: (() => {
                                    Get.to(() => EditProduct(product: product))
                                  }),
                              child: const Icon(
                                Icons.edit,
                                size: 24,
                              ),
                            ), */
                            right: 60,
                            top: 20,
                          ),
                          Positioned(
                            child: GestureDetector(
                              onTap: (() {
                                showConfirmDelete(context);
                              }),
                              child: const Icon(
                                Icons.delete,
                                size: 24,
                              ),
                            ),
                            right: 20,
                            top: 20,
                          ),
                          Positioned(
                            child: Text(product.name,
                                style: GoogleFonts.roboto(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w900)),
                            left: 40,
                            top: 70,
                          ),
                          Positioned(
                            child: /* Image.network(
                              product.urlImage,
                              fit: BoxFit.contain,
                              width: 250,
                              height: 200,
                            ), */
                                CachedNetworkImage(
                              height: 200,
                              width: 250,
                              placeholder: (context, url) => Lottie.asset(
                                'assets/downloading.json',
                                width: 30,
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              imageUrl: product.urlImage,
                            ),
                            left: 70,
                            top: 110,
                          ),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              // DefaultTextStyle(
              //   style: TextStyleCustom.regular20(),
              //   child: AnimatedTextKit(
              //     animatedTexts: [
              //       WavyAnimatedText('Detalle Producto',
              //           speed: const Duration(milliseconds: 200))
              //     ],
              //     totalRepeatCount: 1,
              //   ),
              // ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(() {
                    return productController.editProduct.value
                        ? Column(
                            children: [
                              Text(
                                'Detalle Producto',
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
                              DetailBox(product: product),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton.icon(
                                    onPressed: (() {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          barrierColor: ThemeCustom
                                              .primarySwatch
                                              .withOpacity(0.5),
                                          backgroundColor:
                                              ThemeCustom.primarySwatch,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            topLeft: Radius.circular(30),
                                          )),
                                          context: context,
                                          builder: (context) {
                                            return AddMovement(
                                                product: product);
                                          });
                                      //Get.to(() => AddMovement(product: product));
                                    }),
                                    icon: const Icon(Icons.move_down_rounded),
                                    label: Text(
                                      'Realizar Movimiento',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          )
                        : EditProduct(product: product);
                  }))
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showConfirmDelete(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext con) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            titleTextStyle: TextStyleCustom.regular20(),
            contentTextStyle: const TextStyle(color: Colors.white),
            backgroundColor: ThemeCustom.primarySwatch,
            title: const Text('Eliminar producto'),
            content: Text(
                'Por favor confirma si deseas eliminar ${product.name} del inventario.'),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.cancel_outlined, color: Colors.white),
                label: Text(
                  'Regresar',
                  style: TextStyleCustom.regular16(),
                ),
              ),
              TextButton.icon(
                onPressed: ((() => productController.deleteProduct(product))),
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  'Aceptar',
                  style: TextStyleCustom.regular16(),
                ),
              ),
            ],
          );
        });
  }
}

class DetailBox extends StatelessWidget {
  final Product product;
  const DetailBox({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(5, 117, 230, 100),
              Color.fromRGBO(2, 27, 121, 100),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    product.category,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Presentacion',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 1,
              ),
              Column(
                children: [
                  Text(
                    product.quantity.toString(),
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Stock',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 1,
              ),
              Column(
                children: [
                  Text(
                    '\$ ${product.costPrice}',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Precio costo',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
