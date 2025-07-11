import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:kauje_mobile/app/widgets/app_dialog.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final Rx<File?> cvFile = Rx<File?>(null);
  final RxString cvFileName = ''.obs;

  final ImagePicker imagePicker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  final profilePicture = ''.obs;
  final isLoading = false.obs;
  final isEditing = false.obs;
  final isLock = true.obs;

  void editProfile() {
    isEditing.value = !isEditing.value;
    print('Editing profile: ${isEditing.value}');
  }

  void lockProfile() {
    isLock.value = !isLock.value;
    print('Locking profile: ${isLock.value}');
  }

  Future<void> getProfilePicture() async {
    try {
      final picture = AppImages.profile;
      profilePicture.value = picture;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile picture: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      } else {
        Get.snackbar(
          'No Image Selected',
          'Please select an image to upload.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Image Picker Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> pickCvFile() async {
    try {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        cvFile.value = File(pickedFile.path);
        cvFileName.value = pickedFile.name;
      } else {
        Get.snackbar(
          'No CV Selected',
          'Please select a CV to upload.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'CV Picker Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearCvFile() {
    cvFile.value = null;
    cvFileName.value = '';
  }

  Future<void> logout() async {
    // if (isLoading.value) return;

    // try {
    //   await authController.logout();
    // } catch (e) {
    //   Get.snackbar(
    //     'Logout Error',
    //     e.toString(),
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
    try {
      AppDialog.showConfirmationDialog(
        title: 'Konfirmasi Keluar',
        message: 'Apakah Anda yakin ingin keluar?',
        confirmText: 'Ya',
        cancelText: 'Batal',
        onConfirm: () async {
          await authController.logout();
        },
      );
    } catch (e) {
      AppDialog.showErrorDialog(
        title: 'Logout Error',
        message: e.toString(),
        buttonText: 'OK',
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
