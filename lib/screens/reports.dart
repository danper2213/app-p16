import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Reportes',
        style: TextStyle(fontSize: 20, color: Colors.white),
      )),
    );
  }
}
