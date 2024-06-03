import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_p16/controllers/product_controller.dart';
import 'package:app_p16/screens/product/detail_product.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final productController = Get.put(ProductController());
  final TextEditingController searchController = TextEditingController();
  bool iskeyboardVisible = false;

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '¡Hola, ${productController.authController.userProfile!.displayName!.toString()}!',
            style: TextStyleCustom.kanitFont(
              fontWeight: FontWeight.bold,
              size: 18,
            ),
          ),
          Text(
            'Fecha: ${productController.getDateFormat()}',
            style: TextStyleCustom.kanitFont(
              size: 18,
            ),
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9.0),
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: ThemeCustom.buildGradiente(
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Total Productos',
                    style: TextStyleCustom.kanitFont(
                      size: 18,
                    )),
                Obx((() => Text(productController.totalProducts.toString(),
                    style: TextStyleCustom.kanitFont(
                      fontWeight: FontWeight.bold,
                      size: 20,
                    ))))
              ],
            ),
            Column(
              children: [
                Text('Saldo total',
                    style: TextStyleCustom.kanitFont(
                      size: 18,
                    )),
                Obx((() => Text('\$ ${productController.totalP}',
                    style: TextStyleCustom.kanitFont(
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ))))
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 20,
        child: DefaultTextStyle(
          style: TextStyleCustom.kanitFont(
            size: 16,
          ),
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
      KeyboardVisibilityBuilder(builder: (context, isVisible) {
        iskeyboardVisible = isVisible;
        return TextFormField(
          autofocus: false,
          onChanged: (value) => productController.filterProduct(value),
          decoration: InputDecoration(
              label: AnimatedTextKit(animatedTexts: [
                TyperAnimatedText(
                  'Buscar producto',
                  speed: const Duration(milliseconds: 100),
                )
              ]),
              suffixIcon: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  searchController.clear();
                  productController.filterProduct('');
                },
                color: Colors.white,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              )),
          controller: searchController,
          style: TextStyleCustom.kanitFont(size: 16),
        );
      }),
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
    super.key,
    required this.productController,
  });

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
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
                            decoration: ThemeCustom.buildGradiente(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0))),
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
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleCustom.kanitFont(
                                      size: 18, fontWeight: FontWeight.bold)),
                              subtitle: (productController
                                          .foundProducts[index].quantity ==
                                      0)
                                  ? Text('Producto sin existencia',
                                      style: TextStyleCustom.kanitFont(
                                          color: Colors.cyanAccent))
                                  : Text(
                                      'Cantidad: ${productController.foundProducts[index].quantity}',
                                      style: TextStyleCustom.kanitFont(
                                        size: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                              tileColor: Colors.transparent,
                              trailing: const Icon(
                                Icons.arrow_circle_right_sharp,
                                color: ColorCustom.whiteColor,
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
