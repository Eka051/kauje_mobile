import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/entypo.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/category_tab.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/menu_item.dart';
import 'package:kauje_mobile/app/modules/home/views/widgets/news_card.dart';
import 'package:kauje_mobile/app/theme/app_colors.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/dot_indicator.dart';

import '../controllers/home_controller.dart';
import 'package:kauje_mobile/app/data/models/news.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
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
                        Image.asset(
                          AppImages.kaujeLogo,
                          width: 150,
                          height: 150,
                        ),
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
                                    Iconify(Ph.identification_card, size: 32),
                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child: SvgPicture.asset(
                                    //     AppIconsSvg.idCard,
                                    //     width: 32,
                                    //     height: 32,
                                    //   ),
                                    // ),
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
                    const SizedBox(height: 52),
                    Obx(() {
                      final newsList = controller.newsList;
                      final int maxPerPage = 3;
                      final int totalPages = (newsList.length / maxPerPage)
                          .ceil();
                      int currentPage = controller.currentNewsIndex.value;
                      if (currentPage >= totalPages)
                        currentPage = totalPages - 1;
                      final int startIdx = currentPage * maxPerPage;
                      final int endIdx =
                          (startIdx + maxPerPage) > newsList.length
                          ? newsList.length
                          : (startIdx + maxPerPage);
                      final List<NewsItem> newsPage = newsList.sublist(
                        startIdx,
                        endIdx,
                      );
                      return SizedBox(
                        height: 234 * newsPage.length.toDouble() + 24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 600),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                              child: Column(
                                key: ValueKey(currentPage),
                                children: [
                                  ...newsPage.map(
                                    (news) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: NewsCard(
                                        key: ValueKey(news.title),
                                        subtitle: news.subtitle,
                                        title: news.title,
                                        category: news.category,
                                        date: news.date,
                                        imageUrl: news.imageUrl,
                                        onTap: () => controller.onNewsTap(
                                          controller.newsList.indexOf(news),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                totalPages,
                                (i) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  child: DotIndicator(
                                    isActive: currentPage == i,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Obx(
                () => Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * 0.45,
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
      ),
    );
  }
}
