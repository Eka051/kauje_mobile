import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  void onLogin() {
    // TODO: Implement login logic
    final email = loginEmailController.text;
    final password = loginPasswordController.text;
    // print('Login: $email, $password');
  }

  void onRegister() {
    // TODO: Implement register logic
    final email = registerEmailController.text;
    final password = registerPasswordController.text;
    // print('Register: $email, $password');
  }

  //TODO: Implement AuthController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
