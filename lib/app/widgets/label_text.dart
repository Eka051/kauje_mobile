import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class LabelText extends StatelessWidget {
  final String text;
  final int fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const LabelText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.toDouble(),
        color: color ?? context.textTheme.bodyMedium?.color,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
