import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AlumniController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
