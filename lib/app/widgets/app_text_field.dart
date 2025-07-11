import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? hintSize;
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
  final Widget? suffixIcon;
  final int? borderRadius;
  final bool showBorder;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintSize,
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
    this.suffixIcon,
    this.borderRadius,
    this.showBorder = true,
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
            fontSize: hintSize ?? 14,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: context.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 10),
            borderSide: showBorder
                ? BorderSide(color: context.colorScheme.borderPrimary)
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 10),
            borderSide: showBorder
                ? BorderSide(color: context.colorScheme.borderPrimary)
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 10),
            borderSide: showBorder
                ? BorderSide(color: context.colorScheme.primary, width: 1.6)
                : BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 10),
            borderSide: showBorder
                ? BorderSide(color: context.colorScheme.error, width: 1.4)
                : BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding > 0 ? verticalPadding : 12,
          ),
          counterText: '',
          suffixIcon: showPasswordToggle
              ? GestureDetector(
                  onTap: onTogglePassword,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: SvgPicture.asset(
                      isObscured ? AppIcons.eyeOff : AppIcons.eyeOn,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.labelColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              : suffixIcon,
        ),
      ),
    );
  }
}
