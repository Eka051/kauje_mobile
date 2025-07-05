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
      category: 'Berita',
      date: '2 Juli 2025',
      imageUrl:
          'https://kauje.id/wp-content/uploads/2025/06/WhatsApp-Image-2025-06-08-at-22.36.09-800x1067.jpeg',
    ),
    NewsItem(
      subtitle: 'EVENT',
      title: 'Seminar Nasional KAUJE 2025',
      category: 'Event',
      date: '10 Juli 2025',
      imageUrl:
          'https://awsimages.detik.net.id/community/media/visual/2024/12/29/ketua-umum-pimpinan-pusat-keluarga-alumni-universitas-jember-kauje-m-sarmuji-melantik-jajaran-pengurus-pusat-kauje-periode-202_169.jpeg?w=650',
    ),
    NewsItem(
      subtitle: 'PRESTASI',
      title: 'Alumni KAUJE Raih Penghargaan Nasional',
      category: 'Prestasi',
      date: '1 Juli 2025',
      imageUrl:
          'https://i0.wp.com/newbiz.id/wp-content/uploads/2023/09/Kauje-4-Ini.jpg?resize=630%2C380&ssl=1',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _newsTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (newsList.isEmpty) return;
      int next = (currentNewsIndex.value + 1) % newsList.length;
      currentNewsIndex.value = next;
    });
  }

  @override
  void onClose() {
    _newsTimer?.cancel();
    super.onClose();
  }

  void increment() => count.value++;

  void onNewsTap(int index) {}

  void updateSelectedCategory(int index) {
    selectedCategory.value = index;
  }
}
