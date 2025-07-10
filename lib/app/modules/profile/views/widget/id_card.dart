import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

class IdCard extends StatefulWidget {
  final String name;
  final String nim;
  final String profileImage;
  final String faculty;
  final String major;
  final ValueChanged<bool>? onToggle;

  const IdCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.nim,
    required this.faculty,
    required this.major,
    this.onToggle,
  });

  @override
  State<IdCard> createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {
  bool showIdCard = false;

  void _toggleIdCard() {
    setState(() {
      showIdCard = !showIdCard;
      widget.onToggle?.call(showIdCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
      child: Padding(
        padding: EdgeInsets.only(bottom: showIdCard ? 16.0 : 24.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: showIdCard
              ? _idCard(context, key: const ValueKey('idCard'))
              : _profileCard(context, key: const ValueKey('profileCard')),
        ),
      ),
    );
  }

  Widget _profileCard(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.surfaceContainer,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(widget.profileImage),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                  inset: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: RichText(
              text: TextSpan(
                text: '${widget.name}\n',
                style: AppThemeExtension(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: widget.nim,
                    style: AppThemeExtension(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: _toggleIdCard,
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Flexible(
                    child: Text(
                      'Ketuk Untuk Melihat ID-Card',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_upward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _idCard(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.surfaceContainer,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppImages.iDCARD,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 8,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '2023-2026',
                            style: AppThemeExtension(
                              context,
                            ).textTheme.labelSmall,
                          ),
                          QrImageView(
                            data: widget.nim,
                            version: QrVersions.min,
                            size: 85,
                            gapless: false,
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),
                      Image.asset(AppImages.kaujeLogo, height: 35),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 8,
                  right: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: context.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.asset(
                                  widget.profileImage,
                                  height: 48,
                                  width: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            RichText(
                              text: TextSpan(
                                text: '${widget.name}\n',
                                style: AppThemeExtension(
                                  context,
                                ).textTheme.bodyLarge,
                                children: [
                                  TextSpan(
                                    text: widget.nim,
                                    style: AppThemeExtension(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            text: '${widget.faculty}\n',
                            style: AppThemeExtension(
                              context,
                            ).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: widget.major,
                                style: AppThemeExtension(
                                  context,
                                ).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.surfaceContainer,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AppFilledButton(
                    onPressed: _toggleIdCard,
                    color: context.colorScheme.surface,
                    text: 'Tutup',
                    textColor: context.colorScheme.onSurface,
                    prefixIcon: Icon(
                      Icons.arrow_back,
                      color: context.colorScheme.onSurface,
                    ),
                    iconColor: context.colorScheme.onSurface,
                    height: 32,
                    borderRadius: 4,
                    borderSide: BorderSide(
                      color: context.colorScheme.accent,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.surfaceContainer,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Unduh ID-Card',
                    textColor: context.colorScheme.onSurface,
                    iconColor: context.colorScheme.onSurface,
                    suffixIcon: SvgPicture.asset(
                      AppIcons.downloadIcon,
                      height: 18,
                    ),
                    height: 32,
                    borderRadius: 4,
                    borderSide: BorderSide(
                      color: context.colorScheme.accent,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
