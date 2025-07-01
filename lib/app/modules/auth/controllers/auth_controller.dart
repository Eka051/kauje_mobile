import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthFlowState { splashing, auth }

class AuthController extends GetxController {
  final flowState = AuthFlowState.splashing.obs;
  final showWelcomeLogoAgain = false.obs;

  late AnimationController logoAnimationController;
  late Animation<double> logoPositionAnimation;
  late Animation<double> logoOpacityAnimation;

  late AnimationController bottomContainerAnimationController;
  late Animation<double> bottomContainerAnimation;

  late AnimationController welcomeLogoAgainAnimationController;
  late Animation<double> welcomeLogoAgainAnimation;
  late Animation<double> welcomeLogoAgainFadeOutAnimation;

  late AnimationController authSheetAnimationController;
  late Animation<double> authSheetAnimation;

  late TabController tabController;
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  void initAnimations(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);

    logoAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    logoPositionAnimation = Tween<double>(begin: 0, end: 500).animate(
      CurvedAnimation(
        parent: logoAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
    logoOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: logoAnimationController, curve: Curves.easeIn),
    );

    bottomContainerAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    bottomContainerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: bottomContainerAnimationController,
        curve: Curves.easeInOutQuart,
      ),
    );

    welcomeLogoAgainAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    welcomeLogoAgainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: welcomeLogoAgainAnimationController,
        curve: Curves.slowMiddle,
      ),
    );

    authSheetAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    );
    authSheetAnimation = Tween<double>(begin: 0.0, end: 0.95).animate(
      CurvedAnimation(
        parent: authSheetAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    welcomeLogoAgainFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(
          CurvedAnimation(
            parent: authSheetAnimationController,
            curve: Curves.easeOut,
          ),
        );
  }

  void startFlow() async {
    logoAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    bottomContainerAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    showWelcomeLogoAgain.value = true;
    welcomeLogoAgainAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    flowState.value = AuthFlowState.auth;
    authSheetAnimationController.forward();
  }

  void onLogin() {
    final email = loginEmailController.text;
    final password = loginPasswordController.text;
    Get.snackbar(
      "Login Attempt",
      "Email: $email, Password: ${password.isNotEmpty ? 'Provided' : 'Empty'}",
    );
  }

  void onRegister() {
    final email = registerEmailController.text;
    final password = registerPasswordController.text;
    Get.snackbar(
      "Register Attempt",
      "Email: $email, Password: ${password.isNotEmpty ? 'Provided' : 'Empty'}",
    );
  }

  @override
  void onClose() {
    logoAnimationController.dispose();
    bottomContainerAnimationController.dispose();
    welcomeLogoAgainAnimationController.dispose();
    authSheetAnimationController.dispose();
    tabController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    super.onClose();
  }
}
