import 'package:get/get.dart';
import 'package:kauje_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:kauje_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:kauje_mobile/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
