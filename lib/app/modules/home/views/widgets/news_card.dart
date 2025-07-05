import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String category;
  final String date;
  final String imageUrl;
  final VoidCallback? onTap;

  const NewsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.date,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                stops: const [0.7, 0.95],
                colors: [
                  Colors.black.withAlpha(80),
                  context.colorScheme.primary.withAlpha(100),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                subtitle,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        title,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: category,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                            const TextSpan(text: ' • '),
                            TextSpan(
                              text: date,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.surface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Baseline(
                              baseline: 12,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(
                                'Baca Selengkapnya',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: context.colorScheme.surface,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
