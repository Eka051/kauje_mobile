import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color,
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
  final double? width;
  final double? height;
  final int? textSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color ?? context.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBackgroundColor: color != null
              ? color!
              : context.colorScheme.neutral,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: Colors.white),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: textColor ?? context.colorScheme.onSurface,
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
