import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.suffixIcon,
    this.prefixIcon,
    this.color,
    this.iconColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.borderSide,
    this.borderRadius,
    this.width,
    this.height,
    this.textSize,
    this.textColor,
  });
  final VoidCallback? onPressed;
  final String text;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final BorderSide? borderSide;
  final int? borderRadius;
  final double? width;
  final double? height;
  final int? textSize;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          side:
              borderSide ??
              BorderSide(
                color: color != null
                    ? context.colorScheme.accent
                    : context.colorScheme.borderPrimary,
                width: 1,
              ),
          backgroundColor: color ?? context.colorScheme.primary,
          disabledForegroundColor:
              disabledForegroundColor ?? context.colorScheme.textOnSecondary,
          disabledBackgroundColor:
              disabledBackgroundColor ??
              (color != null ? color! : context.colorScheme.borderPrimary),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 8)],
            Text(
              text,
              style: TextStyle(
                color: isDisabled
                    ? (disabledForegroundColor ??
                          context.colorScheme.surface.withAlpha(153))
                    : (textColor ?? Colors.white),
                fontSize: textSize?.toDouble() ?? 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
          ],
        ),
      ),
    );
  }
}
