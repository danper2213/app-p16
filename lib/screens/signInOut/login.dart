import 'package:app_p16/controllers/auth_controller.dart';

import 'package:app_p16/screens/signInOut/sign_up.dart';
import 'package:app_p16/widgets/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController _authController =
      Get.put<AuthController>(AuthController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  height: 30.0,
                ),
                Text(
                  '¡Hola, Bienvenido a Inventario P16!',
                  style: GoogleFonts.kanit(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30.0,
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
                  child: Obx((() => ElevatedButton.icon(
                        icon: _authController.isSignedIn.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(Icons.login_rounded),
                        onPressed: () => {
                          _authController.isSignedIn.value
                              ? null
                              : _authController.login(
                                  emailController.text.trim(),
                                  passwordController.text)
                        },
                        label: Text(
                          _authController.isSignedIn.value
                              ? 'Ingresando'
                              : 'Ingresar',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20.0),
                        ),
                      ))),
                ),
                Row(
                  children: [
                    const Text(
                      '¿Necesitas una cuenta?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () => {Get.to(() => SignUp())},
                      child: Text(
                        'Registrate',
                        style: TextStyleCustom.kanitFont(
                            size: 14, color: ColorCustom.marineBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
