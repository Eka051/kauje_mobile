import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kauje_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            AppFilledButton(onPressed: () => authController.logout(), text: 'Logout')
          ]
        )
      ),
    );
  }
}
