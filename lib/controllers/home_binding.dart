import 'package:app_p16/controllers/auth_controller.dart';
import 'package:app_p16/controllers/home_controller.dart';
import 'package:app_p16/controllers/movements_controller.dart';
import 'package:app_p16/controllers/product_controller.dart';
import 'package:get/get.dart';

class BindingControllers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<MovementsController>(() => MovementsController());
  }
}
