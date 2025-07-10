import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

class Avatar extends StatelessWidget {
  final String? profilePic;
  final String? initials;
  final double avatarSize;

  const Avatar({
    super.key,
    this.profilePic,
    this.initials,
    this.avatarSize = 96,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (profilePic != null && profilePic!.isNotEmpty) {
      if (profilePic!.startsWith('http')) {
        imageProvider = NetworkImage(profilePic!);
      } else {
        imageProvider = AssetImage(profilePic!);
      }
    } else {
      imageProvider = AssetImage(AppImages.profile);
    }
    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.primary,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary,
                blurRadius: 8,
                offset: const Offset(0, 0),
                spreadRadius: 2,
                inset: true,
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.neutralVariant,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.surfaceContainer,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    inset: true,
                  ),
                ],
                border: Border.all(
                  color: context.colorScheme.surface,
                  width: 2,
                ),
              ),
              child: SvgPicture.asset(
                AppIcons.camera,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
