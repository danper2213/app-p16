import 'dart:io';

import 'package:app_p16/models/movement.dart';
import 'package:app_p16/models/product.dart';
import 'package:app_p16/screens/home.dart';
import 'package:app_p16/widgets/get_date_format.dart';
import 'package:app_p16/widgets/get_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Firestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProduct() {
    return _firebaseFirestore
        .collection('products')
        .orderBy('quantity', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Movement>> getAllMovements() {
    return _firebaseFirestore
        .collection('movements')
        .where('created_date', isEqualTo: getDateFormat())
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Movement.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Movement>> getAllMovementsByDate(String date) {
    return _firebaseFirestore
        .collection('movements')
        .where('created_date', isEqualTo: date)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Movement.fromSnapshot(doc)).toList();
    });
  }

  Future uploadImage(String path, File file, Product product) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);
    String url = '';
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      product.urlImage = url;
      await addProduct(product);
    }).catchError((error) {
      getSnack('¡Ocurrio un error!', 'La imagen no pudo subir',
          Colors.redAccent, Icons.error_outline_rounded);
    });
  }

  Future<void> addProduct(Product product) async {
    final docProduct = _firebaseFirestore.collection('products').doc();
    product.id = docProduct.id;
    await docProduct
        .set(product.toJson())
        .then((value) => getSnack(
            '¡Producto exitosamente agregado!',
            'El producto ha sido agregado correctamente',
            const Color.fromRGBO(0, 150, 199, 1),
            Icons.check_circle_outline_rounded))
        .catchError((onError) => getSnack(
            '¡Ocurrio un error!',
            'El producto no sido agregado ',
            Colors.redAccent,
            Icons.error_outline_rounded));
  }

  Future<void> updateProduct(
      Product product, String category, int costPrice) async {
    final docProduct =
        _firebaseFirestore.collection('products').doc(product.id);
    //product.id = docProduct.id;
    await docProduct
        .update(<String, dynamic>{'category': category, 'costPrice': costPrice})
        .then((value) => getSnack(
            '¡Producto exitosamente agregado!',
            'El producto ha sido agregado correctamente',
            const Color.fromRGBO(0, 150, 199, 1),
            Icons.check_circle_outline_rounded))
        .catchError((onError) => getSnack('¡Ocurrio un error! &', '$onError ',
            Colors.redAccent, Icons.error_outline_rounded));
  }

  Future<void> deleteProduct(Product product) async {
    final docProduct =
        _firebaseFirestore.collection('products').doc(product.id);
    await docProduct
        .delete()
        .then((value) => getSnack(
            '¡Producto exitosamente eliminado!',
            'El producto ha sido elimiado correctamente',
            const Color.fromRGBO(0, 150, 199, 1),
            Icons.check_circle_outline_rounded))
        .catchError((onError) => getSnack('¡Ocurrio un error! &', '$onError ',
            Colors.redAccent, Icons.error_outline_rounded));
  }

  Future<void> addMovement(Movement movement, Product product) async {
    CollectionReference movements = _firebaseFirestore.collection('movements');
    await movements.add(movement.toJson()).then(
        (value) => changeQuantity(product, movement.quantity, movement.type));
  }

  Future<void> changeQuantity(
      Product product, int quantity, String type) async {
    CollectionReference products = _firebaseFirestore.collection('products');
    var totalDB = totalQuantity(product.quantity, quantity, type);

    await products.doc(product.id).update({'quantity': totalDB}).then((value) {
      getSnack(
          '¡Movimiento exitoso!',
          'Se ha realizado el movimiento exitoso de ${product.name}',
          const Color.fromRGBO(0, 150, 199, 1),
          Icons.check_circle_outline_rounded);
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAll(() => const Home());
      });
    });
  }

  int totalQuantity(int actualQuantity, int newQuanity, String type) {
    if (newQuanity > actualQuantity && type.contains('Salida')) return 0;
    if (type.contains('Entrada')) {
      return actualQuantity + newQuanity;
    } else {
      return actualQuantity - newQuanity;
    }
  }
}
