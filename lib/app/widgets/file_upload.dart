import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

class FileUpload extends StatelessWidget {
  final String fileName;
  final VoidCallback onPickFile;
  final VoidCallback? onClearFile;
  final String hintText;

  const FileUpload({
    super.key,
    required this.fileName,
    required this.onPickFile,
    this.onClearFile,
    this.hintText = 'Unggah Berkas',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPickFile,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.colorScheme.borderPrimary,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.uploadIcon,
              colorFilter: ColorFilter.mode(
                context.colorScheme.labelColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                fileName.isNotEmpty ? fileName : hintText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.tertiary.withAlpha(125),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fileName.isNotEmpty && onClearFile != null)
              GestureDetector(
                onTap: onClearFile,
                child: Icon(
                  Icons.close,
                  color: context.colorScheme.labelColor,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
