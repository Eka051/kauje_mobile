import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late AnimationController sheetHeightAnimationController;
  late Animation<double> sheetHeightAnimation;

  late TabController tabController;
  late PageController registerPageController;
  final currentRegisterPage = 0.obs;

  final loginNimController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final fullnameController = TextEditingController();
  final registerNimController = TextEditingController();
  final emailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final facultyController = TextEditingController();
  final studyProgramController = TextEditingController();
  final graduationYearController = TextEditingController();
  File? transkripIjazahFile;
  final transkripIjazahFileName = ''.obs;

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userNimKey = 'userNim';
  static const String _lastRegisterPageKey = 'lastRegisterPage';

  final isPasswordLoginVisible = true.obs;
  final isPasswordRegisterVisible = true.obs;
  final isConfirmPasswordRegisterVisible = true.obs;
  final isLoginValid = false.obs;
  final isRegisterValid = false.obs;
  final isLoggedIn = false.obs;

  void initAnimations(TickerProvider vsync) {
    tabController = TabController(length: 2, vsync: vsync);
    registerPageController = PageController();

    tabController.addListener(() {
      if (tabController.index == 1) {
        sheetHeightAnimationController.forward();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (registerPageController.hasClients) {
            registerPageController.animateToPage(
              currentRegisterPage.value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      } else {
        sheetHeightAnimationController.reverse();
        _saveLastRegisterPage(currentRegisterPage.value);
      }
      registerValid();
    });

    logoAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    logoPositionAnimation = Tween<double>(begin: 0, end: 700).animate(
      CurvedAnimation(
        parent: logoAnimationController,
        curve: Curves.easeInOutQuad,
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
        curve: Curves.easeInOutQuad,
      ),
    );
    welcomeLogoAgainAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );
    welcomeLogoAgainAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: welcomeLogoAgainAnimationController,
        curve: Curves.slowMiddle,
      ),
    );
    authSheetAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1800),
    );
    authSheetAnimation = Tween<double>(begin: 0.0, end: 0.95).animate(
      CurvedAnimation(
        parent: authSheetAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    sheetHeightAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    sheetHeightAnimation = Tween<double>(begin: 280.0, end: 140.0).animate(
      CurvedAnimation(
        parent: sheetHeightAnimationController,
        curve: Curves.easeInOut,
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

  void toggleConfirmPasswordRegister() {
    isConfirmPasswordRegisterVisible.value =
        !isConfirmPasswordRegisterVisible.value;
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
    if (currentRegisterPage.value == 0) {
      final fullnameValid = fullnameController.text.trim().isNotEmpty;
      final nimError = validateNimNIK(registerNimController.text);
      final emailValid =
          emailController.text.trim().isNotEmpty &&
          emailController.text.contains('@');

      isRegisterValid.value = (fullnameValid && nimError == null && emailValid);
    } else {
      final passwordError = validatePassword(registerPasswordController.text);
      final confirmPasswordValid =
          registerPasswordController.text ==
          registerConfirmPasswordController.text;
      final facultyValid = facultyController.text.trim().isNotEmpty;
      final studyProgramValid = studyProgramController.text.trim().isNotEmpty;
      final graduationYearValid = graduationYearController.text
          .trim()
          .isNotEmpty;
      final transkripValid = transkripIjazahFileName.value.isNotEmpty;

      isRegisterValid.value =
          (passwordError == null &&
          confirmPasswordValid &&
          facultyValid &&
          studyProgramValid &&
          graduationYearValid &&
          transkripValid);
    }
    return isRegisterValid.value;
  }

  Future<void> _loadLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
      this.isLoggedIn.value = isLoggedIn;

      final lastRegisterPage = prefs.getInt(_lastRegisterPageKey) ?? 0;
      currentRegisterPage.value = lastRegisterPage;
    } catch (e) {
      isLoggedIn.value = false;
      currentRegisterPage.value = 0;
    }
  }

  Future<void> _saveLastRegisterPage(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastRegisterPageKey, pageIndex);
  }

  Future<void> _saveLoginStatus(bool status, {String? nimNik}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, status);
    isLoggedIn.value = status;

    if (nimNik != null) {
      await prefs.setString(_userNimKey, nimNik);
    }
  }

  Future<void> logout() async {
    await _saveLoginStatus(false);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNimKey);
    Get.offAllNamed('/auth');
  }

  Future<String?> getUserNim() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNimKey);
  }

  Future<bool> checkLoginStatus() async {
    await _loadLoginStatus();
    return isLoggedIn.value;
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
      await _saveLoginStatus(true, nimNik: nim);
      Get.dialog(
        AlertDialog(
          title: Text("Login Berhasil"),
          content: Text("Selamat datang kembali!"),
          actions: [
            TextButton(
              onPressed: () => Get.offAllNamed('/home'),
              child: Text("OK"),
            ),
          ],
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

  void nextRegisterPage() {
    if (currentRegisterPage.value == 0 && isRegisterValid.value) {
      currentRegisterPage.value = 1;
      _saveLastRegisterPage(1);
      registerPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _validateRegisterForm();
    }
  }

  void previousRegisterPage() {
    if (currentRegisterPage.value == 1) {
      currentRegisterPage.value = 0;
      _saveLastRegisterPage(0);
      registerPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _validateRegisterForm();
    }
  }

  Future<void> pickTranskripIjazahFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
        withData: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        transkripIjazahFile = File(file.path!);
        transkripIjazahFileName.value = file.name;
        _validateRegisterForm();
      } else {
        Get.snackbar(
          'Info',
          'Tidak ada file yang dipilih',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih file: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearTranskripIjazahFile() {
    transkripIjazahFile = null;
    transkripIjazahFileName.value = '';
    _validateRegisterForm();
  }

  Future<void> register() async {
    if (currentRegisterPage.value == 0) {
      nextRegisterPage();
      return;
    }

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
    fullnameController.addListener(_validateRegisterForm);
    emailController.addListener(_validateRegisterForm);
    registerConfirmPasswordController.addListener(_validateRegisterForm);
    facultyController.addListener(_validateRegisterForm);
    studyProgramController.addListener(_validateRegisterForm);
    graduationYearController.addListener(_validateRegisterForm);
    transkripIjazahFileName.listen((_) => _validateRegisterForm());

    _validateLoginForm();
    _validateRegisterForm();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLoginStatus();
    });
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
    fullnameController.removeListener(_validateRegisterForm);
    emailController.removeListener(_validateRegisterForm);
    registerConfirmPasswordController.removeListener(_validateRegisterForm);
    facultyController.removeListener(_validateRegisterForm);
    studyProgramController.removeListener(_validateRegisterForm);
    graduationYearController.removeListener(_validateRegisterForm);

    logoAnimationController.dispose();
    bottomContainerAnimationController.dispose();
    welcomeLogoAgainAnimationController.dispose();
    authSheetAnimationController.dispose();
    sheetHeightAnimationController.dispose();
    tabController.dispose();
    registerPageController.dispose();
    loginNimController.dispose();
    loginPasswordController.dispose();
    registerNimController.dispose();
    registerPasswordController.dispose();
    fullnameController.dispose();
    emailController.dispose();
    registerConfirmPasswordController.dispose();
    facultyController.dispose();
    studyProgramController.dispose();
    graduationYearController.dispose();
    super.onClose();
  }
}
