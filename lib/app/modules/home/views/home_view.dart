import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/entypo.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/category_tab.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/menu_item.dart';
import 'package:kauje_mobile/app/theme/app_colors.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.accent,
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/bg-gradient.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppImages.kaujeLogo, width: 150, height: 150),
                      IconButton(
                        icon: Iconify(Entypo.bell, size: 32),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Halo, Ahimsa Jenar\n',
                                  style: AppThemeExtension(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                TextSpan(
                                  text: '232410101090',
                                  style: AppThemeExtension(
                                    context,
                                  ).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.surfaceContainer,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Fakultas Ilmu Komputer\n',
                                            style: AppThemeExtension(
                                              context,
                                            ).textTheme.bodyLarge,
                                          ),
                                          TextSpan(
                                            text: 'Sistem Informasi\n',
                                            style: AppThemeExtension(
                                              context,
                                            ).textTheme.bodyLarge,
                                          ),
                                          TextSpan(
                                            text: 'Masuk: 2023',
                                            style: AppThemeExtension(
                                              context,
                                            ).textTheme.bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SvgPicture.asset(
                                      AppIcons.idCard,
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              GridView.count(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 5,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  MenuItem(
                                    icon: AppIcons.etalaseIcon,
                                    text: 'Etalase',
                                    backgroundColor: AppColors.softRed,
                                    onTap: () {},
                                  ),
                                  MenuItem(
                                    icon: AppIcons.alumniIcon,
                                    text: 'Alumni',
                                    backgroundColor: AppColors.softBlue,
                                    onTap: () {},
                                  ),
                                  MenuItem(
                                    icon: AppIcons.lowonganIcon,
                                    text: 'Lowongan',
                                    backgroundColor: AppColors.softRed,
                                    onTap: () {},
                                  ),
                                  MenuItem(
                                    icon: AppIcons.kolaborasiIcon,
                                    text: 'Kolaborasi',
                                    backgroundColor: AppColors.softBlue,
                                    onTap: () {},
                                  ),
                                  MenuItem(
                                    icon: AppIcons.forumIcon,
                                    text: 'Forum',
                                    backgroundColor: AppColors.softRed,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Positioned(
                left: 0,
                right: 0,
                top: 390,
                child: CategoryTab(
                  categories: controller.categories,
                  tabIcons: controller.categoryIcons,
                  tabColors: controller.categoryColors,
                  selectedIndex: controller.selectedCategory.value,
                  onTap: controller.updateSelectedCategory,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
