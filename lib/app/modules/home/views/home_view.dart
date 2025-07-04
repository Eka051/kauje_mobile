import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kauje_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/gradient-bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.colorScheme.accent.withAlpha(40),
                  context.colorScheme.surfaceContainerHighest.withAlpha(40),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFilledButton(
                  onPressed: () => authController.logout(),
                  text: 'Logout',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
