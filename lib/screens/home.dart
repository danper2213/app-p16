import 'package:app_p16/controllers/home_controller.dart';

import 'package:app_p16/screens/movements/movements.dart';
import 'package:app_p16/screens/product/products_list.dart';
import 'package:app_p16/screens/reports.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:app_p16/controllers/auth_controller.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/animate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _authController = Get.put<AuthController>(AuthController());
    final _homeController = Get.put<HomeController>(HomeController());
    return GetBuilder<HomeController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Image.asset(
              'assets/logotipo.png',
              width: 45,
              height: 45,
            )
                .animate()
                .fade(duration: const Duration(milliseconds: 500))
                .scale(delay: const Duration(milliseconds: 500)),
            centerTitle: true,
            backgroundColor: ThemeCustom.primarySwatch,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () => {_authController.logOut()},
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '¡Hola, ${_authController.userProfile!.displayName!.toString()}!',
                          style: TextStyleCustom.regular18(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /* DefaultTextStyle(
                          style: TextStyleCustom.regular20(),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(
                                '${_authController.userProfile!.displayName!.toString()}!',
                              )
                            ],
                          ),
                        ), */
                      ],
                    ),
                    Text(
                      'Fecha: ' + getDateFormat(),
                      style: TextStyleCustom.regular16(
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: IndexedStack(index: controller.tabIndex, children: [
                    ProductList(),
                    Movements(),
                    const Reports(),
                  ]),
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: ColorCustom.marineBlue,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              backgroundColor: ThemeCustom.primarySwatch,
              unselectedItemColor: Colors.white,
              items: [
                _bottonNavigationBarItem(
                    icon: Icons.inventory, label: 'Principal'),
                _bottonNavigationBarItem(
                    icon: Icons.move_down, label: 'Movimientos'),
                _bottonNavigationBarItem(
                    icon: Icons.app_registration_outlined, label: 'Registros'),
              ]),
        ),
      );
    });
  }

  String getDateFormat() {
    DateTime now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }
}

_bottonNavigationBarItem({IconData? icon, String? label}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
