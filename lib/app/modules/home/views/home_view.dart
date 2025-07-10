import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/category_tab.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/menu_item.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/news_card_animation.dart';
import 'package:kauje_mobile/app/theme/app_colors.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/header.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppImages.bgGradient, fit: BoxFit.fitWidth),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(0, -40),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Header(),
                                  _buildUserProfile(context),
                                  const SizedBox(height: 52),
                                  _buildNewsSection(controller),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => Positioned(
                              left: 0,
                              right: 0,
                              top: MediaQuery.of(context).size.height * 0.4,
                              child: CategoryTab(
                                categories: controller.categories,
                                tabIcons: controller.categoryIcons,
                                tabColors: controller.categoryColors,
                                selectedIndex:
                                    controller.selectedCategory.value,
                                onTap: controller.updateSelectedCategory,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // // STACK
    );
    // STACK
  }

  Widget _buildUserProfile(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildUserInfo(context), _buildUserCard(context)],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Halo, Ahimsa Jenar\n',
              style: AppThemeExtension(context).textTheme.titleMedium,
            ),
            TextSpan(
              text: '232410101090',
              style: AppThemeExtension(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.surfaceContainer,
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserCardHeader(context),
          const SizedBox(height: 12),
          _buildMenuGrid(),
        ],
      ),
    );
  }

  Widget _buildUserCardHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Fakultas Ilmu Komputer\n',
                  style: AppThemeExtension(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: 'Sistem Informasi\n',
                  style: AppThemeExtension(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: 'Masuk: 2023',
                  style: AppThemeExtension(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
        SvgPicture.asset(AppIcons.idCard, width: 32, height: 32),
      ],
    );
  }

  Widget _buildMenuGrid() {
    return GridView.count(
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
    );
  }

  Widget _buildNewsSection(HomeController controller) {
    return Obx(() {
      final cardGroups = controller.buildNewsGroups();
      if (cardGroups.isEmpty) return const SizedBox();
      return Column(
        children: List.generate(cardGroups.length, (cardIndex) {
          final group = cardGroups[cardIndex];
          final cardId = 'card_$cardIndex';
          return group.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    NewsCardAnimation(
                      cardId: cardId,
                      newsItems: group,
                      controller: controller,
                      onNewsTap: (news) =>
                          controller.onNewsTap(controller.getNewsIndex(news)),
                    ),
                    if (cardIndex < cardGroups.length - 1)
                      const SizedBox(height: 24),
                  ],
                );
        }),
      );
    });
  }
}
