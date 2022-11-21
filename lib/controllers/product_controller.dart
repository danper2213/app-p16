import 'dart:developer';
import 'dart:io';

import 'package:app_p16/models/product.dart';
import 'package:app_p16/screens/home.dart';

import 'package:app_p16/services/firestore.dart';

import 'package:app_p16/widgets/utils.dart';
import 'package:file_picker/file_picker.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart' as intl;

import 'package:get/get.dart';

class ProductController extends GetxController {
  final productsList = <Product>[].obs;
  final foundProducts = <Product>[].obs;
  RxBool editProduct = true.obs;

  get totalP => totalCostPrice();

  get totalProducts => productsList.length;

  PlatformFile? pickedFile;
  CroppedFile? imageFile;

  var loading = true.obs;
  var loadingAdd = false.obs;

  @override
  void onInit() {
    fetchAllProduct();
    super.onInit();
  }

  void changeEditStatus(bool value) {
    editProduct.value = value;
  }

  totalCostPrice() {
    try {
      final formatter = intl.NumberFormat.decimalPattern();
      var total = productsList
          .map((product) => product.costPrice * product.quantity)
          .reduce((value, element) => value + element);
      return formatter.format(total);
    } catch (e) {
      log('Cargando datos');
    }
    return 0;
  }

  void addProduct(Product product) async {
    loadingAdd.value = true;
    final path = 'products/${imageFile!.path.toString()}';
    final file = File(imageFile!.path.toString());
    await Firestore().uploadImage(path, file, product);
    await Future.delayed(const Duration(seconds: 3));
    loadingAdd.value = false;
  }

  void updateProduct(Product product, String category, int costPrice) async {
    await Firestore().updateProduct(product, category, costPrice);
  }

  void deleteProduct(Product product) async {
    await Firestore().deleteProduct(product);
    await Future.delayed(const Duration(seconds: 3));
    Get.to(() => const Home());
  }

  void fetchAllProduct() async {
    try {
      loading(true);
      await Future.delayed(const Duration(seconds: 1));
      productsList.bindStream(Firestore().getAllProduct());
      foundProducts.value = productsList;
    } finally {
      loading(false);
    }
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    pickedFile = result.files.first;
    update();
  }

  Future<void> cropImage() async {
    await Utils.selectImage().then((selectedFile) async {
      if (selectedFile == null) return;
      await Utils.cropSelectedImage(selectedFile.path).then((value) {
        imageFile = value;
        update();
      });
    });
  }

  void filterProduct(String productName) {
    List<Product> results = [];
    if (productName.isEmpty) {
      results = productsList;
    } else {
      results = productsList
          .where((p) => p.name
              .toString()
              .toLowerCase()
              .contains(productName.toLowerCase()))
          .toList();
    }
    foundProducts.value = results;
  }
}
