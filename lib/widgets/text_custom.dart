import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextInputType typeInput;
  final TextEditingController controller;
  const TextFormFieldCustom(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.icon,
      required this.typeInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          label: Text(
            labelText,
            style: const TextStyle(color: Colors.white),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          )),
      controller: controller,
      keyboardType: typeInput,
    );
  }
}
