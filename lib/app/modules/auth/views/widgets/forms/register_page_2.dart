import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_text_field.dart';
import 'package:kauje_mobile/app/widgets/file_upload.dart';
import 'package:kauje_mobile/app/widgets/label_text.dart';
import '../../../controllers/auth_controller.dart';

class RegisterPage2 extends StatelessWidget {
  final AuthController controller;
  const RegisterPage2({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => controller.registerPageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: context.colorScheme.onSurface,
                  size: 24,
                ),
                const SizedBox(width: 4),
                Baseline(
                  baseline: 16,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    'Kembali',
                    style: AppThemeExtension(context).textTheme.bodyLarge!,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          LabelText(text: 'Fakultas', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.facultyController,
            hintText: 'Masukkan fakultas',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          LabelText(text: 'Program Studi', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.studyProgramController,
            hintText: 'Masukkan program studi',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          LabelText(text: 'Tahun Lulus', fontSize: 14),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.graduationYearController,
            hintText: 'Masukkan tahun lulus',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              LabelText(text: 'Transkrip Nilai/Ijazah', fontSize: 14),
              LabelText(
                text: '*',
                fontSize: 14,
                color: context.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () => FileUpload(
              fileName: controller.transkripIjazahFileName.value,
              onPickFile: controller.pickTranskripIjazahFile,
              onClearFile: controller.clearTranskripIjazahFile,
            ),
          ),
          const SizedBox(height: 12),
          LabelText(
            text: '*Bukti kelulusan dapat berupa file PDF, PNG, & JPG',
            fontSize: 12,
            color: context.colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
