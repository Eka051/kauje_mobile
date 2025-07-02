import 'package:flutter/material.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import '../../../controllers/auth_controller.dart';
import '../forms/login_form.dart';
import '../forms/register_form.dart';

class FullSheet extends StatelessWidget {
  final AuthController controller;

  const FullSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final totalHeight = screenHeight * 0.95;

    return SizedBox(
      height: totalHeight,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: controller.sheetHeightAnimationController,
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: controller.sheetHeightAnimation.value - 100,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.colorScheme.accent,
                        context.colorScheme.surface,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Image.asset(
                        AppImages.kaujeLogo,
                        width: double.infinity,
                        height: 56,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: controller.sheetHeightAnimation.value,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      AuthTabBar(controller: controller),
                      Expanded(
                        child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            LoginForm(controller: controller),
                            RegisterForm(controller: controller),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AuthTabBar extends StatelessWidget {
  final AuthController controller;

  const AuthTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 52,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: context.colorScheme.borderSecondary,
              width: 1,
            ),
          ),
          child: TabBar(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            labelColor: context.colorScheme.onSurface,
            unselectedLabelColor: context.colorScheme.onSurfaceVariant,
            indicator: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: context.colorScheme.dividerColor.withAlpha(150),
                width: 2,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicatorPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ),
            tabs: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: Tab(
                  child: AnimatedBuilder(
                    animation: controller.tabController,
                    builder: (context, child) {
                      final selected = controller.tabController.index == 0;
                      return Text(
                        'Masuk',
                        textAlign: TextAlign.center,
                        style: AppThemeExtension(context).textTheme.bodyLarge!
                            .copyWith(
                              color: selected
                                  ? context.colorScheme.onSurface
                                  : context.colorScheme.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: Tab(
                  child: AnimatedBuilder(
                    animation: controller.tabController,
                    builder: (context, child) {
                      final selected = controller.tabController.index == 1;
                      return Text(
                        'Daftar',
                        textAlign: TextAlign.center,
                        style: AppThemeExtension(context).textTheme.bodyLarge!
                            .copyWith(
                              color: selected
                                  ? context.colorScheme.onSurface
                                  : context.colorScheme.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
