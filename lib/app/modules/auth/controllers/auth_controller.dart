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
  final loginNimController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final registerNimController = TextEditingController();
  final registerPasswordController = TextEditingController();

  final isPasswordLoginVisible = true.obs;
  final isPasswordRegisterVisible = true.obs;
  final isLoginValid = false.obs;
  final isRegisterValid = false.obs;

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

  void togglePasswordLogin() {
    isPasswordLoginVisible.value = !isPasswordLoginVisible.value;
  }

  void togglePasswordRegister() {
    isPasswordRegisterVisible.value = !isPasswordRegisterVisible.value;
  }

  String? validateNimNIK(String? value) {
    if (value == null || value.isEmpty) {
      return "NIM/NIK tidak boleh kosong";
    }
    if (value.length < 12) {
      return "NIM/NIK minimal 12 digit";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 6) {
      return "Password harus minimal 6 karakter";
    }
    return null;
  }

  bool loginValid() {
    final nimError = validateNimNIK(loginNimController.text);
    final passwordError = validatePassword(loginPasswordController.text);

    isLoginValid.value = (nimError == null && passwordError == null);
    return isLoginValid.value;
  }

  bool registerValid() {
    final nimError = validateNimNIK(registerNimController.text);
    final passwordError = validatePassword(registerPasswordController.text);

    isRegisterValid.value = (nimError == null && passwordError == null);
    return isRegisterValid.value;
  }

  Future<void> login() async {
    final nim = loginNimController.text;
    final password = loginPasswordController.text;
    final nimError = validateNimNIK(nim);

    if (nimError != null) {
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(nimError),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
      return;
    }

    if (nim == "202010102020" && password == "password") {
      Get.dialog(
        AlertDialog(
          title: Text("Login Berhasil"),
          content: Text("Selamat datang kembali!"),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
    } else {
      Get.dialog(
        AlertDialog(
          title: Text("Login Gagal"),
          content: Text("NIM atau Password salah"),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
    }
  }

  Future<void> register() async {
    final nim = registerNimController.text;
    final password = registerPasswordController.text;

    final nimError = validateNimNIK(nim);
    final passwordError = validatePassword(password);

    if (nimError != null) {
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(nimError),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
      return;
    }
    if (passwordError != null) {
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(passwordError),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
      return;
    }

    if (nim == "202010102020" && password == "password") {
      Get.dialog(
        AlertDialog(
          title: Text("Success"),
          content: Text("Registrasi Berhasil"),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
    } else {
      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text("NIM atau Password salah"),
          actions: [TextButton(onPressed: () => Get.back(), child: Text("OK"))],
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    loginNimController.addListener(_validateLoginForm);
    loginPasswordController.addListener(_validateLoginForm);
    registerNimController.addListener(_validateRegisterForm);
    registerPasswordController.addListener(_validateRegisterForm);

    _validateLoginForm();
    _validateRegisterForm();
  }

  void _validateLoginForm() {
    loginValid();
  }

  void _validateRegisterForm() {
    registerValid();
  }

  @override
  void onClose() {
    loginNimController.removeListener(_validateLoginForm);
    loginPasswordController.removeListener(_validateLoginForm);
    registerNimController.removeListener(_validateRegisterForm);
    registerPasswordController.removeListener(_validateRegisterForm);

    logoAnimationController.dispose();
    bottomContainerAnimationController.dispose();
    welcomeLogoAgainAnimationController.dispose();
    authSheetAnimationController.dispose();
    tabController.dispose();
    loginNimController.dispose();
    loginPasswordController.dispose();
    registerNimController.dispose();
    registerPasswordController.dispose();
    super.onClose();
  }
}
