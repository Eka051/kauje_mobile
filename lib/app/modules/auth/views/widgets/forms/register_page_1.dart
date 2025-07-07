import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/widgets/app_text_field.dart';
import 'package:kauje_mobile/app/widgets/label_text.dart';
import '../../../controllers/auth_controller.dart';

class RegisterPage1 extends StatelessWidget {
  final AuthController controller;
  const RegisterPage1({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabelText(text: 'Nama Lengkap', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.fullnameController,
            hintText: 'Masukkan nama lengkap',
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
            ],
          ),
          const SizedBox(height: 16),
          LabelText(text: 'NIM/NIK', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.registerNimController,
            hintText: 'Masukkan NIM/NIK',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 16),
          LabelText(text: 'Email', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.emailController,
            hintText: 'Masukkan email',
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@._-]")),
            ],
          ),
          const SizedBox(height: 16),
          LabelText(text: 'Password', fontSize: 14),
          const SizedBox(height: 8),
          Obx(
            () => AppTextField(
              controller: controller.registerPasswordController,
              hintText: 'Masukkan password',
              obscureText: controller.isPasswordRegisterVisible.value,
              passwordChar: '*',
              keyboardType: TextInputType.visiblePassword,
              showPasswordToggle: true,
              onTogglePassword: () => controller.togglePasswordVisibility(
                controller.isPasswordRegisterVisible,
              ),
            ),
          ),
          const SizedBox(height: 16),
          LabelText(text: 'Konfirmasi Password', fontSize: 14),
          const SizedBox(height: 8),
          Obx(
            () => AppTextField(
              controller: controller.registerConfirmPasswordController,
              hintText: 'Masukkan konfirmasi password',
              obscureText: controller.isConfirmPasswordRegisterVisible.value,
              passwordChar: '*',
              keyboardType: TextInputType.visiblePassword,
              showPasswordToggle: true,
              onTogglePassword: () => controller.togglePasswordVisibility(
                controller.isConfirmPasswordRegisterVisible,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
