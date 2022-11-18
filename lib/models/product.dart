import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  final String name;
  final String category;
  final int costPrice;
  final int quantity;
  String urlImage;

  Product(
      {this.id = '',
      required this.name,
      required this.category,
      required this.costPrice,
      required this.quantity,
      required this.urlImage});

  static Product fromSnapshot(DocumentSnapshot snapshot) {
    Product product = Product(
        id: snapshot['id'],
        name: snapshot['name'],
        category: snapshot['category'],
        costPrice: snapshot['costPrice'] as int,
        quantity: snapshot['quantity'] as int,
        urlImage: snapshot['urlImage']);
    return product;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'costPrice': costPrice,
        'quantity': quantity,
        'urlImage': urlImage
      };
}
