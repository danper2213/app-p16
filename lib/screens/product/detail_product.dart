import 'package:app_p16/controllers/movements_controller.dart';
import 'package:app_p16/controllers/product_controller.dart';
import 'package:app_p16/models/product.dart';
import 'package:app_p16/screens/movements/add_movement.dart';
import 'package:app_p16/screens/product/edit_product.dart';
import 'package:app_p16/screens/product/product_register.dart';
import 'package:app_p16/widgets/shake_transition.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DetailProduct extends StatelessWidget {
  final Product product;
  DetailProduct({super.key, required this.product});

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
              Hero(
                  tag: product,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: ThemeCustom.buildGradiente(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(100.0))),
                      width: double.infinity,
                      height: 330,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 20,
                            child: GestureDetector(
                              onTap: (() => Get.back()),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 24,
                              ),
                            ),
                          ),
                          Positioned(
                            //Edit product
                            right: 60,
                            top: 20,
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
                          ),
                          Positioned(
                            right: 20,
                            top: 20,
                            child: GestureDetector(
                              onTap: (() {
                                showConfirmDelete(context);
                              }),
                              child: const Icon(
                                Icons.delete,
                                size: 24,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            top: 70,
                            child: ShakeTransition(
                              child: Text(product.name,
                                  style: TextStyleCustom.kanitFont(
                                    fontWeight: FontWeight.bold,
                                    size: 25,
                                  )),
                            ),
                          ),
                          Positioned(
                            left: 70,
                            top: 110,
                            child: /* Image.network(
                              product.urlImage,
                              fit: BoxFit.contain,
                              width: 250,
                              height: 200,
                            ), */
                                ShakeTransition(
                              child: CachedNetworkImage(
                                fadeInCurve: Curves.easeInCirc,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Obx(() {
                    return productController.editProduct.value
                        ? Column(
                            children: [
                              Text(
                                'Detalle Producto',
                                style: TextStyleCustom.kanitFont(
                                  fontWeight: FontWeight.w600,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DetailBox(
                                  product: product,
                                  productController: productController),
                              const SizedBox(
                                height: 20,
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
                                              product: product,
                                            );
                                          });
                                      //Get.to(() => AddMovement(product: product));
                                    }),
                                    icon: const Icon(Icons.move_down_rounded),
                                    label: Text(
                                      'Realizar Movimiento',
                                      style: TextStyleCustom.kanitFont(
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton.icon(
                                    onPressed: (() {
                                      Get.to(
                                        () => ProductoHistory(product: product),
                                      );
                                    }),
                                    icon: const Icon(Icons.history),
                                    label: Text(
                                      'Consultar Historico',
                                      style: TextStyleCustom.kanitFont(
                                        size: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
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
  final ProductController productController;
  const DetailBox(
      {super.key, required this.product, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: ThemeCustom.buildGradiente(
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    product.category,
                    style: GoogleFonts.kanit(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Presentación',
                    style: GoogleFonts.kanit(
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
                    style: GoogleFonts.kanit(
                      height: 0,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Stock',
                    style: GoogleFonts.kanit(
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
                    '\$ ${productController.convertToThousand(product.costPrice)}',
                    style: GoogleFonts.kanit(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Precio costo',
                    style: GoogleFonts.kanit(
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
