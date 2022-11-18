import 'package:cloud_firestore/cloud_firestore.dart';

class Movement {
  final String name;
  final String type;
  final int quantity;
  final String createdBy;
  final String createdDate;

  Movement(
      {required this.name,
      required this.type,
      required this.quantity,
      required this.createdBy,
      required this.createdDate});

  static Movement fromSnapshot(DocumentSnapshot snapshot) {
    Movement product = Movement(
        name: snapshot['name'],
        type: snapshot['type'],
        quantity: snapshot['quantity'] as int,
        createdBy: snapshot['created_by'],
        createdDate: snapshot['created_date']);
    return product;
  }

//DateTime.parse(snapshot['created_date'].toString())
  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'quantity': quantity,
        'created_by': createdBy,
        'created_date': createdDate
      };
}
