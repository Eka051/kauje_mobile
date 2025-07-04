import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';
import 'package:kauje_mobile/app/widgets/app_text_field.dart';
import 'package:kauje_mobile/app/widgets/label_text.dart';
import '../../../controllers/auth_controller.dart';

class LoginForm extends StatelessWidget {
  final AuthController controller;
  const LoginForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabelText(text: 'NIK/NIM', fontSize: 14),
            const SizedBox(height: 8),
            AppTextField(
              controller: controller.loginNimController,
              hintText: 'Masukkan NIK/NIM',
              maxLength: 16,
              obscureText: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            LabelText(text: 'Password', fontSize: 14),
            const SizedBox(height: 8),
            Obx(
              () => AppTextField(
                controller: controller.loginPasswordController,
                hintText: 'Masukkan password',
                obscureText: controller.isPasswordLoginVisible.value,
                passwordChar: '*',
                keyboardType: TextInputType.visiblePassword,
                showPasswordToggle: true,
                onTogglePassword: () => controller.togglePasswordVisibility(
                  controller.isPasswordLoginVisible,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => AppFilledButton(
                onPressed: controller.isLoginValid.value
                    ? () => controller.login()
                    : null,
                text: 'Masuk',
                height: 56,
                textSize: 16,
                textColor: context.colorScheme.onSurface,
                disabledForegroundColor: context.colorScheme.textOnSecondary,
                color: controller.isLoginValid.value
                    ? context.colorScheme.primary
                    : context.colorScheme.borderPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
