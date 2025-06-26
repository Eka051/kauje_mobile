import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashscreenController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController logoAnimationController;
  late final Animation<double> logoAnimation;
  late final Animation<double> opacityAnimation;

  late final AnimationController bottomContainerAnimationController;
  late final Animation<double> bottomContainerAnimation;

  late final AnimationController welcomeLogoAgainAnimationController;
  late final Animation<double> welcomeLogoAgainAnimation;

  final RxBool showWelcomeLogoAgain = false.obs;

  void startSplashSequence() async {
    await logoAnimationController.forward();
    await bottomContainerAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    showWelcomeLogoAgain.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    welcomeLogoAgainAnimationController.forward();
  }

  @override
  void onReady() {
    super.onReady();
    startSplashSequence();
  }

  @override
  void onInit() {
    super.onInit();
    logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    logoAnimation = Tween<double>(begin: 0, end: 1000).animate(
      CurvedAnimation(
        parent: logoAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );
    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: logoAnimationController, curve: Curves.easeIn),
    );

    bottomContainerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    bottomContainerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: bottomContainerAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    welcomeLogoAgainAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    welcomeLogoAgainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: welcomeLogoAgainAnimationController,
        curve: Curves.easeIn,
      ),
    );
  }

  void resetWelcomeLogoAgain() {
    showWelcomeLogoAgain.value = false;
    welcomeLogoAgainAnimationController.reset();
  }

  @override
  void onClose() {
    logoAnimationController.dispose();
    bottomContainerAnimationController.dispose();
    welcomeLogoAgainAnimationController.dispose();
    super.onClose();
  }
}
