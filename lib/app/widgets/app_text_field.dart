import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final double? height;
  final double? width;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool showPasswordToggle;
  final bool? enabled;
  final bool? readOnly;
  final String? passwordChar;
  final VoidCallback? onTogglePassword;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.height,
    this.width,
    this.maxLength,
    this.inputFormatters,
    this.showPasswordToggle = false,
    this.enabled,
    this.readOnly,
    this.passwordChar,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTextField(context, obscureText);
  }

  Widget _buildTextField(BuildContext context, bool isObscured) {
    final double verticalPadding = height != null ? (height! - 40) / 2 : 12;

    return SizedBox(
      width: width,
      child: TextFormField(
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        controller: controller,
        obscureText: isObscured,
        keyboardType: keyboardType,
        obscuringCharacter: passwordChar ?? '•',
        inputFormatters: inputFormatters,
        enabled: enabled,
        readOnly: readOnly ?? false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.tertiary.withAlpha(125),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: context.colorScheme.borderPrimary),
          ),
          suffixIcon: showPasswordToggle
              ? GestureDetector(
                  onTap: onTogglePassword,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: SizedBox(
                      child: SvgPicture.asset(
                        isObscured ? AppIcons.eyeOff : AppIcons.eyeOn,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.labelColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding > 0 ? verticalPadding : 12,
          ),
          counterText: '',
        ),
      ),
    );
  }
}
