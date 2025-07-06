import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void onTabTapped(int index) {
    selectedIndex.value = index;
  }
}
