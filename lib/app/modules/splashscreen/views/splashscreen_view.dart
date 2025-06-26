import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splashscreen_controller.dart';
import '../../../theme/app_theme.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller.logoAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg-splashscreen.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Transform.translate(
                    offset: Offset(0, controller.logoAnimation.value),
                    child: Opacity(
                      opacity: controller.opacityAnimation.value,
                      child: Image.asset(
                        'assets/images/welcome-logo.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: controller.bottomContainerAnimationController,
                builder: (context, child) {
                  final animationValue =
                      controller.bottomContainerAnimation.value;
                  return Transform.translate(
                    offset: Offset(0, 115 * (1 - animationValue)),
                    child: Opacity(
                      opacity: animationValue,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 115,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                context.colorScheme.lightYellow,
                                context.colorScheme.surface,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Center(
                              child: Image.asset(
                                'assets/images/kauje-logo.png',
                                width: double.infinity,
                                height: 56,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Obx(() {
                return controller.showWelcomeLogoAgain.value
                    ? Center(
                        child: FadeTransition(
                          opacity: controller.welcomeLogoAgainAnimation,
                          child: Image.asset(
                            'assets/images/welcome-logo.png',
                            width: 300,
                            height: 300,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          );
        },
      ),
    );
  }
}
