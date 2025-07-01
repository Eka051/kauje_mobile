import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final double? height;
  final double? width;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool showPasswordToggle;
  final String? passwordChar;
  final VoidCallback? onTogglePassword;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.height,
    this.width,
    this.maxLength,
    this.inputFormatters,
    this.showPasswordToggle = false,
    this.passwordChar,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTextField(context, obscureText);
  }

  Widget _buildTextField(BuildContext context, bool isObscured) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        controller: controller,
        obscureText: isObscured,
        keyboardType: keyboardType,
        obscuringCharacter: passwordChar ?? '•',
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: context.colorScheme.borderPrimary),
          ),
          suffixIcon: showPasswordToggle
              ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: context.colorScheme.textSecondary,
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          counterText: '',
        ),
      ),
    );
  }
}
