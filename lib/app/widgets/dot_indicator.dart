import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? borderRadius;
  final Duration duration;

  const DotIndicator({
    super.key,
    required this.isActive,
    this.activeColor,
    this.inactiveColor,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 40,
      child: AnimatedContainer(
        duration: duration,
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isActive
              ? (activeColor ?? Theme.of(context).colorScheme.primary)
              : (inactiveColor ?? AppTheme.light.colorScheme.gray20),
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
    );
  }
}
