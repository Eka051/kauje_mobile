import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/modules/auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController instituteController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final File cvController = File('');

  final ImagePicker imagePicker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  final profilePicture = ''.obs;
  final isLock = false.obs;

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

  Future<void> logout() async {
    try {
      await authController.logout();
    } catch (e) {
      Get.snackbar(
        'Logout Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
