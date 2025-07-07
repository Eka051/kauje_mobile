import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/data/models/news.dart';
import 'package:kauje_mobile/app/theme/app_colors.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final RxInt selectedCategory = 0.obs;
  final RxInt currentNewsIndex = 0.obs;
  Timer? _newsTimer;

  final Map<String, int> _rotatingNewsIndices = <String, int>{}.obs;
  final Map<String, Timer?> _rotatingNewsTimers = <String, Timer?>{}.obs;

  final List<String> categories = [
    'Populer',
    'Kolaborasi',
    'Berita',
    'Etalase',
    'Lowongan',
  ];

  final List<String> categoryIcons = [
    AppTabIcon.populer,
    AppTabIcon.kolaborasi,
    AppTabIcon.berita,
    AppTabIcon.etalase,
    AppTabIcon.lowongan,
  ];

  final List<Color> categoryColors = [
    AppColors.softRed,
    AppColors.softBlue,
    AppColors.softRed,
    AppColors.softBlue,
    AppColors.softRed,
  ];

  final List<NewsItem> newsList = [
    NewsItem(
      subtitle: 'KAUJE INFO',
      title: 'KAUJE Korda Surabaya Bakti Sosial Kurban',
      category: 'Event',
      date: '2 Juli 2025',
      imageUrl:
          'https://kauje.id/wp-content/uploads/2025/06/WhatsApp-Image-2025-06-08-at-22.36.09-800x1067.jpeg',
      popular: true,
    ),
    NewsItem(
      subtitle: 'KAUJE INFO',
      title: 'Seminar Nasional KAUJE 2025',
      category: 'Event',
      date: '10 Juli 2025',
      imageUrl:
          'https://awsimages.detik.net.id/community/media/visual/2024/12/29/ketua-umum-pimpinan-pusat-keluarga-alumni-universitas-jember-kauje-m-sarmuji-melantik-jajaran-pengurus-pusat-kauje-periode-202_169.jpeg?w=650',
      popular: true,
    ),
    NewsItem(
      subtitle: 'PRESTASI',
      title: 'Alumni KAUJE Raih Penghargaan Nasional',
      category: 'Prestasi',
      date: '1 Juli 2025',
      imageUrl:
          'https://i0.wp.com/newbiz.id/wp-content/uploads/2023/09/Kauje-4-Ini.jpg?resize=630%2C380&ssl=1',
      popular: true,
    ),
    NewsItem(
      subtitle: 'KOLABORASI',
      title: 'KAUJE Kolaborasi dengan Pemerintah Daerah',
      category: 'Kolaborasi',
      date: '5 Juli 2025',
      imageUrl:
          'https://cdn.rri.co.id/berita/Jember/o/1745966791000-IMG_4598/cfrpdgxdj921c4p.webp',
      popular: false,
    ),
    NewsItem(
      subtitle: 'PRESTASI',
      title: 'Alumni KAUJE Raih Penghargaan Nasional',
      category: 'Prestasi',
      date: '1 Juli 2025',
      imageUrl:
          'https://i0.wp.com/newbiz.id/wp-content/uploads/2023/09/Kauje-4-Ini.jpg?resize=630%2C380&ssl=1',
      popular: false,
    ),
    NewsItem(
      subtitle: 'KAUJE INFO',
      title: 'KAUJE Korda Surabaya Bakti Sosial Kurban',
      category: 'Berita',
      date: '2 Juli 2025',
      imageUrl:
          'https://kauje.id/wp-content/uploads/2025/06/WhatsApp-Image-2025-06-08-at-22.36.09-800x1067.jpeg',
      popular: true,
    ),
    NewsItem(
      subtitle: 'PRESTASI',
      title: 'Alumni KAUJE Raih Penghargaan Nasional',
      category: 'Berita',
      date: '1 Juli 2025',
      imageUrl:
          'https://i0.wp.com/newbiz.id/wp-content/uploads/2023/09/Kauje-4-Ini.jpg?resize=630%2C380&ssl=1',
      popular: true,
    ),
  ];

  List<NewsItem> getFilteredNews() {
    if (selectedCategory.value == 0) {
      return newsList.where((e) => e.popular == true).toList();
    }
    final category = categories[selectedCategory.value];
    return newsList.where((e) => e.category == category).toList();
  }

  List<List<NewsItem>> buildNewsGroups() {
    final filtered = getFilteredNews();
    if (filtered.isEmpty) return [];
    const int maxPerCard = 3;
    final List<List<NewsItem>> cardGroups = [];
    for (int i = 0; i < filtered.length; i += maxPerCard) {
      final end = (i + maxPerCard > filtered.length)
          ? filtered.length
          : i + maxPerCard;
      cardGroups.add(filtered.sublist(i, end));
    }
    return cardGroups;
  }

  void updateSelectedCategory(int index) {
    _clearAllRotatingNews();
    
    selectedCategory.value = index;
    
    currentNewsIndex.value = 0;
    
    update();
  }

  void _clearAllRotatingNews() {
    for (var timer in _rotatingNewsTimers.values) {
      timer?.cancel();
    }
    _rotatingNewsTimers.clear();
    _rotatingNewsIndices.clear();
  }

  @override
  void onInit() {
    super.onInit();
    _newsTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      final filtered = getFilteredNews();
      if (filtered.isEmpty) return;
      int next = (currentNewsIndex.value + 1) % filtered.length;
      currentNewsIndex.value = next;
    });
  }

  @override
  void onClose() {
    _newsTimer?.cancel();
    _clearAllRotatingNews();
    super.onClose();
  }

  void onNewsTap(int index) {}

  int getNewsIndex(NewsItem news) {
    final filtered = getFilteredNews();
    final index = filtered.indexOf(news);
    return index >= 0 ? index : 0; 
  }

  void startRotatingNews(String cardId, List<NewsItem> newsItems) {
    if (newsItems.length <= 1) return;

    _rotatingNewsTimers[cardId]?.cancel();
    
    _rotatingNewsIndices[cardId] = 0;

    _rotatingNewsTimers[cardId] = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) {
      final currentIndex = _rotatingNewsIndices[cardId] ?? 0;
      _rotatingNewsIndices[cardId] = (currentIndex + 1) % newsItems.length;
      update(['rotating_news_$cardId']);
    });
  }

  void stopRotatingNews(String cardId) {
    _rotatingNewsTimers[cardId]?.cancel();
    _rotatingNewsTimers.remove(cardId);
    _rotatingNewsIndices.remove(cardId);
  }

  int getRotatingNewsIndex(String cardId) {
    return _rotatingNewsIndices[cardId] ?? 0;
  }
}