import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import '../../../controllers/auth_controller.dart';

class SplashWidgets extends StatelessWidget {
  final AuthController controller;

  const SplashWidgets({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller.logoAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, controller.logoPositionAnimation.value),
              child: Opacity(
                opacity: controller.logoOpacityAnimation.value.clamp(0.0, 1.0),
                child: child,
              ),
            );
          },
          child: Image.asset(AppImages.welcomeLogo, width: 300, height: 300),
        ),

        AnimatedBuilder(
          animation: controller.bottomContainerAnimationController,
          builder: (context, child) {
            final animationValue = controller.bottomContainerAnimation.value;
            return Transform.translate(
              offset: Offset(0, 115 * (1 - animationValue)),
              child: Opacity(
                opacity: animationValue.clamp(0.0, 1.0),
                child: child,
              ),
            );
          },
          child: BottomSplashContainer(),
        ),

        Obx(() {
          return controller.showWelcomeLogoAgain.value
              ? FadeTransition(
                  opacity: controller.welcomeLogoAgainAnimation,
                  child: Image.asset(
                    AppImages.welcomeLogo,
                    width: 300,
                    height: 300,
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}

class BottomSplashContainer extends StatelessWidget {
  const BottomSplashContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 115,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.colorScheme.accent, context.colorScheme.surface],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Center(
            child: Image.asset(
              AppImages.kaujeLogo,
              width: double.infinity,
              height: 56,
            ),
          ),
        ),
      ),
    );
  }
}
