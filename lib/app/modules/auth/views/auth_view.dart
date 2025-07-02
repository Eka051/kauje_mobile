import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import '../controllers/auth_controller.dart';
import 'widgets/splash/splash_widgets.dart';
import 'widgets/auth_sheet/full_sheet.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  final AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.initAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.startFlow());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bgSplashscreen),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                if (controller.flowState.value == AuthFlowState.splashing)
                  SplashWidgets(controller: controller)
                else
                  _buildAuthWidgets(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthWidgets() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller.authSheetAnimationController,
            builder: (context, child) {
              return Opacity(
                opacity: controller.welcomeLogoAgainFadeOutAnimation.value
                    .clamp(0.0, 1.0),
                child: Center(
                  child: Image.asset(
                    AppImages.welcomeLogo,
                    width: 300,
                    height: 300,
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: controller.authSheetAnimationController,
            builder: (context, child) {
              final yOffset =
                  MediaQuery.of(context).size.height *
                  0.45 *
                  (1 - controller.authSheetAnimation.value);

              return Positioned(
                left: 0,
                right: 0,
                bottom: -20,
                child: Transform.translate(
                  offset: Offset(0, yOffset),
                  child: child!,
                ),
              );
            },
            child: FullSheet(controller: controller),
          ),
        ],
      ),
    );
  }
}
