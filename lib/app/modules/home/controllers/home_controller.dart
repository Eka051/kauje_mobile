import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_colors.dart';

class HomeController extends GetxController {

  final count = 0.obs;
  final RxInt selectedCategory = 0.obs;

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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void updateSelectedCategory(int index) {
    selectedCategory.value = index;
  }
}
