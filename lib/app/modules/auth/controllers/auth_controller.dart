import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthFlowState { splashing, auth }

class AuthController extends GetxController {
  final flowState = AuthFlowState.splashing.obs;
  final showWelcomeLogoAgain = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  bool _isAnimationsInitialized = false;
  bool get isAnimationsInitialized => _isAnimationsInitialized;

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
    if (_isAnimationsInitialized) return;

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
      validateRegisterForm();
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

    _isAnimationsInitialized = true;
  }

  void startFlow() async {
    if (!_isAnimationsInitialized) return;

    final isUserLoggedIn = await checkLoginStatus();

    logoAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    bottomContainerAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    showWelcomeLogoAgain.value = true;
    welcomeLogoAgainAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 800));

    if (isUserLoggedIn) {
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed('/main');
      return;
    }

    flowState.value = AuthFlowState.auth;
    authSheetAnimationController.forward();
  }

  void setupValidators() {
    final loginControllers = [loginNimController, loginPasswordController];
    final registerControllers = [
      fullnameController,
      registerNimController,
      emailController,
      registerPasswordController,
      registerConfirmPasswordController,
      facultyController,
      studyProgramController,
      graduationYearController,
    ];

    for (var controller in loginControllers) {
      controller.addListener(() {
        validateLoginForm();
      });
    }
    for (var controller in registerControllers) {
      controller.addListener(() {
        validateRegisterForm();
      });
    }

    transkripIjazahFileName.listen((_) {
      validateRegisterForm();
    });
  }

  void togglePasswordVisibility(RxBool visibility) {
    visibility.value = !visibility.value;
  }

  String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama lengkap tidak boleh kosong";
    }
    if (value.length < 3) {
      return "Nama lengkap minimal 3 karakter";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (!value.contains('@')) {
      return "Email tidak valid";
    }
    return null;
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Konfirmasi password tidak boleh kosong";
    }
    if (value != registerPasswordController.text) {
      return "Konfirmasi password tidak cocok";
    }
    return null;
  }

  String? validateFaculty(String? value) {
    if (value == null || value.isEmpty) {
      return "Fakultas tidak boleh kosong";
    }
    return null;
  }

  String? validateStudyProgram(String? value) {
    if (value == null || value.isEmpty) {
      return "Program studi tidak boleh kosong";
    }
    return null;
  }

  String? validateGraduationYear(String? value) {
    if (value == null || value.isEmpty) {
      return "Tahun lulus tidak boleh kosong";
    }
    if (int.tryParse(value) == null) {
      return "Tahun lulus harus berupa angka";
    }
    return null;
  }

  String? validateTranskripIjazahFile(String? value) {
    if (value == null || value.isEmpty) {
      return "Transkrip nilai/Ijazah tidak boleh kosong";
    }
    return null;
  }

  bool validateLoginForm() {
    final nimError = validateNimNIK(loginNimController.text);
    final passwordError = validatePassword(loginPasswordController.text);

    isLoginValid.value = (nimError == null && passwordError == null);
    return isLoginValid.value;
  }

  bool _validateRegisterForm() {
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

  bool validateRegisterForm() {
    return _validateRegisterForm();
  }

  bool get isCurrentFormValid =>
      _isAnimationsInitialized && tabController.index == 0
      ? isLoginValid.value
      : isRegisterValid.value;

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

  Future<void> validateAuthenticatedUser() async {
    final isUserLoggedIn = await checkLoginStatus();
    if (isUserLoggedIn) {
      Get.offAllNamed('/home');
    }
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
              onPressed: () => Get.offAllNamed('/main'),
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
    if (!_isAnimationsInitialized) return;

    if (currentRegisterPage.value == 0 && isRegisterValid.value) {
      currentRegisterPage.value = 1;
      _saveLastRegisterPage(1);
      registerPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      validateRegisterForm();
    }
  }

  void previousRegisterPage() {
    if (!_isAnimationsInitialized) return;

    if (currentRegisterPage.value == 1) {
      currentRegisterPage.value = 0;
      _saveLastRegisterPage(0);
      registerPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      validateRegisterForm();
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
        validateRegisterForm();
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
    validateRegisterForm();
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

  void disposeAnimationControllers() {
    if (!_isAnimationsInitialized) return;

    final controllers = [
      logoAnimationController,
      bottomContainerAnimationController,
      welcomeLogoAgainAnimationController,
      authSheetAnimationController,
      sheetHeightAnimationController,
    ];
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  void disposeTextControllers() {
    final controllers = [
      loginNimController,
      loginPasswordController,
      registerNimController,
      registerPasswordController,
      fullnameController,
      emailController,
      registerConfirmPasswordController,
      facultyController,
      studyProgramController,
      graduationYearController,
    ];

    for (var controller in controllers) {
      controller.dispose();
    }
  }

  @override
  void onInit() {
    super.onInit();

    loginNimController.addListener(validateLoginForm);
    loginPasswordController.addListener(validateLoginForm);
    registerNimController.addListener(validateRegisterForm);
    registerPasswordController.addListener(validateRegisterForm);
    fullnameController.addListener(validateRegisterForm);
    emailController.addListener(validateRegisterForm);
    registerConfirmPasswordController.addListener(validateRegisterForm);
    facultyController.addListener(validateRegisterForm);
    studyProgramController.addListener(validateRegisterForm);
    graduationYearController.addListener(validateRegisterForm);
    transkripIjazahFileName.listen((_) => validateRegisterForm());

    validateLoginForm();
    validateRegisterForm();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLoginStatus();
    });
  }

  @override
  void onClose() {
    loginNimController.removeListener(validateLoginForm);
    loginPasswordController.removeListener(validateLoginForm);
    registerNimController.removeListener(validateRegisterForm);
    registerPasswordController.removeListener(validateRegisterForm);
    fullnameController.removeListener(validateRegisterForm);
    emailController.removeListener(validateRegisterForm);
    registerConfirmPasswordController.removeListener(validateRegisterForm);
    facultyController.removeListener(validateRegisterForm);
    studyProgramController.removeListener(validateRegisterForm);
    graduationYearController.removeListener(validateRegisterForm);

    disposeAnimationControllers();
    disposeTextControllers();

    if (_isAnimationsInitialized) {
      tabController.dispose();
      registerPageController.dispose();
    }

    super.onClose();
  }
}
