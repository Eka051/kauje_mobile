import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/data/models/news.dart';
import 'package:kauje_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/news_card.dart';
import 'package:kauje_mobile/app/widgets/dot_indicator.dart';

class NewsCardAnimation extends StatelessWidget {
  final String cardId;
  final List<NewsItem> newsItems;
  final HomeController controller;
  final Function(NewsItem) onNewsTap;

  const NewsCardAnimation({
    super.key,
    required this.cardId,
    required this.newsItems,
    required this.controller,
    required this.onNewsTap,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (newsItems.length > 1) {
        controller.startRotatingNews(cardId, newsItems);
      }
    });
    
    return GetBuilder<HomeController>(
      id: 'rotating_news_$cardId',
      builder: (controller) {
        final currentIndex = controller.getRotatingNewsIndex(cardId);
        final news = newsItems[currentIndex];
        
        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: NewsCard(
                key: ValueKey(news.title),
                subtitle: news.subtitle,
                title: news.title,
                category: news.category,
                date: news.date,
                imageUrl: news.imageUrl,
                onTap: () => onNewsTap(news),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                newsItems.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: DotIndicator(isActive: index == currentIndex),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}