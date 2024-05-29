import 'package:app_p16/controllers/product_controller.dart';

import 'package:app_p16/screens/movements/movements.dart';
import 'package:app_p16/screens/product/add_product.dart';
import 'package:app_p16/screens/product/products_list.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      controller.fetchAllProduct();
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Image.asset('assets/logotipo.png', width: 45, height: 45),
              centerTitle: true,
              backgroundColor: ThemeCustom.primarySwatch,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () => {controller.authController.logOut()},
                ),
                IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: () =>
                        controller.saveImage(controller.foundProducts)
                    //{controller.productListToPdf(controller.foundProducts)},
                    )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 4, right: 16, left: 16),
              child: Expanded(
                child:
                    IndexedStack(index: controller.tabIndex, children: const [
                  ProductList(),
                  Movements(),
                ]),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
                KeyboardVisibilityBuilder(builder: (ctx, isVisible) {
              return !isVisible
                  ? FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () => Get.to(() => const AddProduct()),
                    )
                  : Container();
            }),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: ColorCustom.marineBlue.withAlpha(255),
              elevation: 0,
              child: BottomNavigationBar(
                  selectedLabelStyle: TextStyleCustom.kanitFont(size: 12),
                  unselectedLabelStyle: TextStyleCustom.kanitFont(size: 10),
                  elevation: 0,
                  selectedItemColor: Colors.cyanAccent,
                  onTap: controller.changeTabIndex,
                  currentIndex: controller.tabIndex,
                  backgroundColor: Colors.transparent,
                  unselectedItemColor: Colors.white,
                  items: [
                    _bottonNavigationBarItem(
                        icon: Icons.inventory, label: 'Principal'),
                    _bottonNavigationBarItem(
                        icon: Icons.move_down, label: 'Movimientos'),
                  ]),
            )),
      );
    });
  }
}

_bottonNavigationBarItem({IconData? icon, String? label}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
