import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';

class ShowcaseController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final count = 0.obs;
  final RxInt selectedCategory = 0.obs;
  final RxInt currentNewsIndex = 0.obs;

  final List<String> categories = ['Populer', 'Filter'];

  final List<String> categoryIcons = [AppTabIcon.populer, AppTabIcon.filter];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
