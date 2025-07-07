import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class MenuItem extends StatelessWidget {
  final String icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
  });

  Color _getTextColor(BuildContext context, Color backgroundColor) {
    final colorScheme = AppTheme.light.colorScheme;

    if (backgroundColor == colorScheme.softRed) {
      return colorScheme.darkRed;
    } else if (backgroundColor == colorScheme.softBlue) {
      return colorScheme.darkBlue;
    }
    return colorScheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(icon, width: 32, height: 32),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getTextColor(context, backgroundColor),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
