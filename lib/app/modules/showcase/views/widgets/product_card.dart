import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String? imageUrl;
  final String title;
  final int price;

  const ProductCard({
    super.key,
    required this.onPressed,
    this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: onPressed,
          child: Card(
            color: context.colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      imageUrl ?? 'assets/images/cleaning-img.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: context.textTheme.bodySmall),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(price),
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
