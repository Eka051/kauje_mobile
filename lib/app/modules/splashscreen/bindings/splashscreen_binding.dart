import 'package:get/get.dart';
import 'package:kauje_mobile/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenController>(
      () => SplashscreenController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
