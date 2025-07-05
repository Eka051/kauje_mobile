import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class CategoryTab extends StatelessWidget {
  final List<String> categories;
  final List<String> tabIcons;
  final List<Color> tabColors;
  final int selectedIndex;
  final void Function(int) onTap;

  const CategoryTab({
    super.key,
    required this.categories,
    required this.tabIcons,
    required this.tabColors,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    tabIcons[index],
                    width: 16,
                    height: 16,
                    colorFilter: isSelected
                        ? ColorFilter.mode(
                            context.colorScheme.error,
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.labelColor,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (_) => onTap(index),
              selectedColor: context.colorScheme.primary,
              backgroundColor:
                  context.colorScheme.surfaceContainerLowest,
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  width: 2,
                  color: isSelected
                      ? context.colorScheme.surface
                      : context.colorScheme.surfaceContainerLowest,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
