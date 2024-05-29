import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextInputType typeInput;
  final TextEditingController controller;
  const TextFormFieldCustom(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.icon,
      required this.typeInput});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          label: Text(
            labelText,
            style: TextStyleCustom.kanitFont(),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          )),
      controller: controller,
      keyboardType: typeInput,
      style: TextStyleCustom.kanitFont(),
    );
  }
}
