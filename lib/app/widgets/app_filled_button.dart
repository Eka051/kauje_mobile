import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.width,
    this.height,
    this.textSize,
    this.textColor,
  });
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
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
          foregroundColor: textColor ?? context.colorScheme.surface,
          backgroundColor: color ?? context.colorScheme.primary,
          disabledForegroundColor:
              disabledForegroundColor ?? context.colorScheme.textOnSecondary,
          disabledBackgroundColor:
              disabledBackgroundColor ??
              (color != null ? color! : context.colorScheme.borderPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: isDisabled
                    ? (disabledForegroundColor ??
                          context.colorScheme.surface.withAlpha(153))
                    : Colors.white,
              ),
            if (icon != null) const SizedBox(width: 8),
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
          ],
        ),
      ),
    );
  }
}
