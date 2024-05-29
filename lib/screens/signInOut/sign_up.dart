import 'package:app_p16/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put<AuthController>(AuthController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(3, 4, 94, 1),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logotipo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Crea tu cuenta',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      label: const Text(
                        'Nombre',
                        style: TextStyle(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      )),
                  controller: nameController,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      label: const Text(
                        'Correo',
                        style: TextStyle(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.email_rounded,
                        color: Colors.white,
                      )),
                  controller: emailController,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: const Text(
                        'Contraseña',
                        style: TextStyle(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: const Icon(
                        Icons.password_rounded,
                        color: Colors.white,
                      )),
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => {
                      authController.signUp(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim())
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text("Registrarse"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
