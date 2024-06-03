import 'dart:io';

import 'package:app_p16/controllers/auth_controller.dart';
import 'package:app_p16/models/product.dart';
import 'package:app_p16/screens/home.dart';

import 'package:app_p16/services/firestore.dart';

import 'package:app_p16/widgets/utils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;
import 'package:printing/printing.dart';

class ProductController extends GetxController {
  final productsList = <Product>[].obs;
  final foundProducts = <Product>[].obs;
  final productsReport = <Product>[].obs;
  RxString nameProduct = ''.obs;
  RxBool editProduct = true.obs;
  var tabIndex = 0;

  final _authController = Get.put<AuthController>(AuthController());

  get authController => _authController;

  get totalP => totalCostPrice();

  get totalProducts => productsList.length;

  PlatformFile? pickedFile;
  CroppedFile? imageFile;

  var loading = true.obs;
  var loadingAdd = false.obs;
  var loadingUpdate = false.obs;
  //loadingUpdate

  void changeEditStatus(bool value) {
    editProduct.value = value;
  }

  String getDateFormat() {
    DateTime now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return formattedDate;
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  totalCostPrice() {
    try {
      final formatter = NumberFormat.decimalPattern();
      var total = productsList
          .map((product) => product.costPrice * product.quantity)
          .reduce((value, element) => value + element);
      return formatter.format(total);
    } catch (e) {
      //log('Cargando datos');
    }
    return 0;
  }

  String convertToThousand(value) {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(value);
  }

  void addProduct(Product product) async {
    loadingAdd.value = true;
    final path = 'products/${imageFile!.path.toString()}';
    final file = File(imageFile!.path.toString());
    await Firestore().uploadImage(path, file, product);
    await Future.delayed(const Duration(seconds: 3));
    loadingAdd.value = false;
  }

  void updateProduct(
      Product product, String name, String category, int costPrice) async {
    loadingUpdate.value = true;
    await Firestore().updateProduct(product, name, category, costPrice);
    loadingUpdate.value = false;
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const Home());
    });
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
      //Create method - Export product list in pdf in tables
      //print('###################################### ${foundProducts.length}');
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

  void filterProductReports(String productName) async {
    List<Product> results = [];
    if (productName.isEmpty) {
      results = [];
    } else {
      results = productsList
          .where((p) => p.name
              .toString()
              .toLowerCase()
              .contains(productName.toLowerCase()))
          .toList();
    }
    productsReport.value = results;
  }

  //Guardar una imagen (url) en el storage del celular
  void saveImage(List<Product> products) async {
    for (var product in products) {
      final dio = Dio();
      final response = await dio.get(
        product.urlImage,
        options: Options(responseType: ResponseType.bytes),
      );

      Directory? directory = await getExternalStorageDirectory();
      File file = File(
          path.join(directory!.path, path.basename('${product.name}.png')));

      await file.writeAsBytes(response.data);
    }
  }

  void productListToPdf(List<Product> productsList) async {
    final pdf = pw.Document();
    final table = pw.Table(
      border: pw.TableBorder.all(),
      children: <pw.TableRow>[
        pw.TableRow(children: <pw.Widget>[
          pw.Text(
            "Nombre",
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            "Precio costo",
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            "Cantidad",
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            "Presentacion",
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
        ]),
      ],
    );
    for (var product in productsList) {
      final row = pw.TableRow(children: <pw.Widget>[
        pw.Text(
          product.name,
        ),
        pw.Text('${product.costPrice}'),
        pw.Text('${product.quantity}'),
        pw.Text(product.category)
      ]);
      table.children.add(row);
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [table];
        },
      ),
    );

    /*
    Directory? tempDir = await getExternalStorageDirectory();
    String? tempPath = tempDir?.path;
    final file = File("$tempPath/productos.pdf");
    file.writeAsBytesSync(await pdf.save());*/

    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
