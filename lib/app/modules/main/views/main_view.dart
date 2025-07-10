import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SizedBox.expand(
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: const [HomeView(), ProfileView()],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withAlpha(40),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            selectedLabelStyle: AppThemeExtension(context).textTheme.bodyMedium
                ?.copyWith(
                  color: context.colorScheme.onSurface,
                  inherit: false,
                ),
            unselectedLabelStyle: AppThemeExtension(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: context.colorScheme.onSurface,
                  inherit: false,
                ),
            selectedItemColor: context.colorScheme.onSurface,
            unselectedItemColor: context.colorScheme.onSurface,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onTabTapped,

            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.selectedIndex.value == 0
                      ? AppIcons.homeFillIcon
                      : AppIcons.homeIcon,
                  width: 32,
                  height: 32,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  controller.selectedIndex.value == 1
                      ? AppIcons.profileFillIcon
                      : AppIcons.profileIcon,
                  width: 32,
                  height: 32,
                ),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
