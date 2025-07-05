import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class CategoryTab extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final void Function(int) onTap;

  const CategoryTab({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              onSelected: (_) => onTap(index),
              selectedColor: AppTheme.light.colorScheme.primary,
              backgroundColor: AppTheme.light.colorScheme.surfaceContainerLowest,
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
