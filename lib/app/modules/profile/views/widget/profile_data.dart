import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
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
                children: [
                  InkWell(
                    onTap: () {},
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color: context.colorScheme.lightBlue,
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
          AppTextField(controller: nameController, hintText: 'Ahimsa Jenar'),
          const SizedBox(height: 12),
          LabelText(text: 'NIM/NIK', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(controller: nimController, hintText: '232410101090'),
          const SizedBox(height: 12),
          LabelText(text: 'Tempat/Tanggal Lahir', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: dateController,
            hintText: 'Jember, 03 Desember 2004',
          ),
          const SizedBox(height: 12),
          LabelText(text: 'Email', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: emailController,
            hintText: 'ahimsa.jenar@example.com',
          ),
          const SizedBox(height: 12),
          LabelText(text: 'No. Telepon', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(controller: phoneController, hintText: '081234567890'),
          const SizedBox(height: 12),
          LabelText(text: 'Instansi', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(controller: instituteController, hintText: '-'),
          const SizedBox(height: 12),
          LabelText(text: 'Fakultas', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: facultyController,
            hintText: 'Fakultas Ilmu Komputer',
          ),
          const SizedBox(height: 12),
          LabelText(text: 'CV', fontSize: 14),
          const SizedBox(height: 8),
          FileUpload(
            fileName: cvFileName,
            onPickFile: pickCvFile,
            onClearFile: clearCvFile,
            hintText: 'Unggah berkas',
          ),
          // InkWell(
          //   borderRadius: BorderRadius.circular(10),
          //   onTap: pickCvFile,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //     decoration: BoxDecoration(
          //       color: context.colorScheme.surface,
          //       borderRadius: BorderRadius.circular(10),
          //       border: Border.all(
          //         color: context.colorScheme.borderPrimary,
          //         width: 1.5,
          //       ),
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.file_upload_outlined,
          //           color: context.colorScheme.textSecondary,
          //           size: 20,
          //         ),
          //         const SizedBox(width: 12),
          //         Expanded(
          //           child: Text(
          //             cvFileName.isNotEmpty ? cvFileName : 'Unggah berkas',
          //             style: AppThemeExtension(context).textTheme.bodyMedium!
          //                 .copyWith(color: context.colorScheme.textSecondary),
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ),
          //         if (cvFileName.isNotEmpty)
          //           GestureDetector(
          //             onTap: clearCvFile,
          //             child: Icon(
          //               Icons.close,
          //               color: context.colorScheme.textSecondary,
          //               size: 20,
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
