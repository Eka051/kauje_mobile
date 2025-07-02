import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';
import '../../../controllers/auth_controller.dart';
import 'register_page_1.dart';
import 'register_page_2.dart';

class RegisterForm extends StatelessWidget {
  final AuthController controller;
  const RegisterForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: PageView(
            controller: controller.registerPageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              controller.currentRegisterPage.value = index;
              controller.registerValid();
            },
            children: [
              RegisterPage1(controller: controller),
              RegisterPage2(controller: controller),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPageIndicator(context),
              const SizedBox(height: 16),
              _buildRegisterButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIndicatorDot(context, 0),
          const SizedBox(width: 8),
          _buildIndicatorDot(context, 1),
        ],
      ),
    );
  }

  Widget _buildIndicatorDot(BuildContext context, int index) {
    final isActive = controller.currentRegisterPage.value == index;
    return Transform.rotate(
      angle: 40,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isActive ? context.colorScheme.primary : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Obx(
      () => AppFilledButton(
        onPressed: controller.isRegisterValid.value
            ? controller.register
            : null,
        text: controller.currentRegisterPage.value == 0
            ? 'Selanjutnya'
            : 'Daftar',
        height: 48,
        textSize: 16,
        disabledForegroundColor: context.colorScheme.textOnSecondary,
        color: controller.isRegisterValid.value
            ? context.colorScheme.primary
            : context.colorScheme.borderPrimary,
      ),
    );
  }
}
