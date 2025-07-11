import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/modules/profile/views/widget/id_card.dart';
import 'package:kauje_mobile/app/modules/profile/views/widget/profile_data.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_outlined_button.dart';
import 'package:kauje_mobile/app/widgets/header.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.accent,
              context.colorScheme.surfaceContainerHighest,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.bgProfileGradient,
                  fit: BoxFit.fitWidth,
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Transform.translate(
                          offset: Offset(0, -40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Header(),
                              Transform.translate(
                                offset: Offset(0, -40),
                                child: Column(
                                  children: [
                                    IdCard(
                                      profileImage: 'assets/images/profil.png',
                                      name: 'Ahimsa Jenar',
                                      nim: '232410101090',
                                      faculty: 'Fakultas Ilmu Komputer',
                                      major: 'Sistem Informasi',
                                    ),
                                    Obx(
                                      () => ProfileData(
                                        profilePic:
                                            controller.profilePicture.value,
                                        avatarSize: 96,
                                        nameController:
                                            controller.nameController,
                                        nimController: controller.nimController,
                                        dateController:
                                            controller.dateController,
                                        emailController:
                                            controller.emailController,
                                        phoneController:
                                            controller.phoneController,
                                        instituteController:
                                            controller.instituteController,
                                        facultyController:
                                            controller.facultyController,
                                        cvFileName: controller.cvFileName.value,
                                        pickCvFile: () {
                                          controller.pickCvFile();
                                        },
                                        clearCvFile: () {
                                          controller.clearCvFile();
                                        },
                                        isEditing: controller.isEditing.value,
                                        onEditProfile: () =>
                                            controller.editProfile(),
                                        onLockProfile: () =>
                                            controller.lockProfile(),
                                        onSave: () => (),
                                        onCancel: () => (),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    AppFilledButton(
                                      text: 'Keluar',
                                      onPressed: controller.logout,
                                      color: context.colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
