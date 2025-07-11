import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';
import 'package:kauje_mobile/app/widgets/app_text_field.dart';
import 'package:kauje_mobile/app/widgets/file_upload.dart';
import 'package:kauje_mobile/app/widgets/label_text.dart';
import 'avatar.dart';

class ProfileData extends StatelessWidget {
  final String? profilePic;
  final String? initials;
  final double avatarSize;
  final TextEditingController nameController;
  final TextEditingController nimController;
  final TextEditingController dateController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController instituteController;
  final TextEditingController facultyController;
  final String cvFileName;
  final VoidCallback pickCvFile;
  final VoidCallback clearCvFile;
  final bool isEditing;
  final VoidCallback onEditProfile;
  final VoidCallback onLockProfile;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ProfileData({
    super.key,
    this.profilePic,
    this.initials,
    this.avatarSize = 96,
    required this.nameController,
    required this.nimController,
    required this.dateController,
    required this.emailController,
    required this.phoneController,
    required this.instituteController,
    required this.facultyController,
    required this.cvFileName,
    required this.pickCvFile,
    required this.clearCvFile,
    required this.isEditing,
    required this.onEditProfile,
    required this.onLockProfile,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [
            context.colorScheme.surfaceContainerHighest,
            context.colorScheme.accent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.surfaceContainer,
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Data Profil\n',
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                  children: [
                    TextSpan(
                      text: 'Lengkapi Data Profil Anda!',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  // edit
                  Material(
                    color: context.colorScheme.softRed,
                    borderRadius: BorderRadius.circular(4.0),
                    child: InkWell(
                      onTap: onEditProfile,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            AppIcons.edit,
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.red,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // lock
                  Material(
                    color: context.colorScheme.softBlue,
                    borderRadius: BorderRadius.circular(4.0),
                    child: InkWell(
                      onTap: onLockProfile,
                      borderRadius: BorderRadius.circular(4.0),
                      splashColor: HSLColor.fromColor(
                        context.colorScheme.blue.withAlpha(30),
                      ).withLightness(0.3).toColor(),
                      highlightColor: HSLColor.fromColor(
                        context.colorScheme.blue.withAlpha(30),
                      ).withLightness(0.5).toColor(),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            AppIcons.lock,
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.blue,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Avatar(
              profilePic: profilePic,
              initials: initials,
              avatarSize: avatarSize,
            ),
          ),
          const SizedBox(height: 12),
          LabelText(text: 'Nama Lengkap', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: nameController,
            hintText: 'Ahimsa Jenar',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'NIM/NIK', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: nimController,
            hintText: '232410101090',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'Tempat/Tanggal Lahir', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: dateController,
            hintText: 'Jember, 03 Desember 2004',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'Email', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: emailController,
            hintText: 'ahimsa.jenar@example.com',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'No. Telepon', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: phoneController,
            hintText: '081234567890',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'Instansi', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: instituteController,
            hintText: '-',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'Fakultas', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: facultyController,
            hintText: 'Fakultas Ilmu Komputer',
            enabled: isEditing,
          ),
          const SizedBox(height: 12),
          LabelText(text: 'CV', fontSize: 14),
          const SizedBox(height: 8),
          FileUpload(
            fileName: cvFileName,
            onPickFile: pickCvFile,
            onClearFile: clearCvFile,
            hintText: 'Unggah berkas',
            isEditing: isEditing,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (isEditing)
                Expanded(
                  child: AppFilledButton(
                    text: 'Batal',
                    textColor: context.colorScheme.onSurface,
                    onPressed: onCancel,
                    color: context.colorScheme.surface,
                    height: 32,
                    prefixIcon: SvgPicture.asset(AppIcons.close, height: 20),
                    borderRadius: 8,
                    borderSide: BorderSide(
                      color: context.colorScheme.borderPrimary,
                      width: 1.5,
                    ),
                  ),
                ),
              if (isEditing) const SizedBox(width: 12),
              if (isEditing)
                Expanded(
                  child: AppFilledButton(
                    text: 'Simpan',
                    textColor: context.colorScheme.onSurface,
                    onPressed: onSave,
                    height: 32,
                    prefixIcon: SvgPicture.asset(AppIcons.save, height: 20),
                    borderRadius: 8,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
