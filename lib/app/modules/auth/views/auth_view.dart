import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_filled_button.dart';
import 'package:kauje_mobile/app/widgets/app_text_field.dart';
import 'package:kauje_mobile/app/widgets/label_text.dart';
import '../controllers/auth_controller.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  final AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.initAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.startFlow());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bgSplashscreen),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                if (controller.flowState.value == AuthFlowState.splashing)
                  _buildSplashWidgets()
                else
                  _buildAuthWidgets(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashWidgets() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller.logoAnimationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, controller.logoPositionAnimation.value),
              child: Opacity(
                opacity: controller.logoOpacityAnimation.value,
                child: child,
              ),
            );
          },
          child: Image.asset(AppImages.welcomeLogo, width: 300, height: 300),
        ),

        AnimatedBuilder(
          animation: controller.bottomContainerAnimationController,
          builder: (context, child) {
            final animationValue = controller.bottomContainerAnimation.value;
            return Transform.translate(
              offset: Offset(0, 115 * (1 - animationValue)),
              child: Opacity(opacity: animationValue, child: child),
            );
          },
          child: _BottomSplashContainer(),
        ),

        Obx(() {
          return controller.showWelcomeLogoAgain.value
              ? FadeTransition(
                  opacity: controller.welcomeLogoAgainAnimation,
                  child: Image.asset(
                    AppImages.welcomeLogo,
                    width: 300,
                    height: 300,
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildAuthWidgets() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller.authSheetAnimationController,
            builder: (context, child) {
              return Opacity(
                opacity: controller.welcomeLogoAgainFadeOutAnimation.value,
                child: Center(
                  child: Image.asset(
                    AppImages.welcomeLogo,
                    width: 300,
                    height: 300,
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: controller.authSheetAnimationController,
            builder: (context, child) {
              final yOffset =
                  MediaQuery.of(context).size.height *
                  0.45 *
                  (1 - controller.authSheetAnimation.value);

              return Positioned(
                left: 0,
                right: 0,
                bottom: -20,
                child: Transform.translate(
                  offset: Offset(0, yOffset),
                  child: child!,
                ),
              );
            },
            child: _FullSheet(controller: controller),
          ),
        ],
      ),
    );
  }
}

class _FullSheet extends StatelessWidget {
  final AuthController controller;

  const _FullSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final totalHeight = screenHeight * 0.9;

    return SizedBox(
      height: totalHeight,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 580,
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
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 380,
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
                  _buildTabBar(context),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        _LoginForm(controller: controller),
                        _RegisterForm(controller: controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tabWidth = 310 / 2;
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
            tabAlignment: TabAlignment.center,
            indicatorPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ),
            tabs: [
              SizedBox(
                width: tabWidth,
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
                width: tabWidth,
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

class _LoginForm extends StatelessWidget {
  final AuthController controller;
  const _LoginForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabelText(
            text: 'NIK/NIM',
            fontSize: 14,
            color: context.colorScheme.textSecondary,
          ),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.loginNimController,
            hintText: 'Masukkan NIK/NIM',
            maxLength: 16,
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 16),
          LabelText(
            text: 'Password',
            fontSize: 14,
            color: context.colorScheme.textSecondary,
          ),
          const SizedBox(height: 8),
          Obx(
            () => AppTextField(
              controller: controller.loginPasswordController,
              hintText: 'Masukkan password',
              obscureText: controller.isPasswordLoginVisible.value,
              passwordChar: '*',
              keyboardType: TextInputType.visiblePassword,
              showPasswordToggle: true,
              onTogglePassword: () => controller.togglePasswordLogin(),
            ),
          ),
          const SizedBox(height: 24),
          Obx(
            () => AppFilledButton(
              onPressed: controller.isLoginValid.value
                  ? () => controller.login()
                  : null,
              text: 'Masuk',
              height: 56,
              textSize: 16,
              disabledForegroundColor: context.colorScheme.textOnSecondary,
              color: controller.isLoginValid.value
                  ? context.colorScheme.primary
                  : context.colorScheme.borderPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final AuthController controller;
  const _RegisterForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabelText(
            text: 'NIK/NIM',
            fontSize: 14,
            color: context.colorScheme.textSecondary,
          ),
          const SizedBox(height: 8),
          AppTextField(
            controller: controller.registerNimController,
            hintText: 'Masukkan NIK/NIM',
            maxLength: 16,
            obscureText: false,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 16),
          LabelText(
            text: 'Password',
            fontSize: 14,
            color: context.colorScheme.textSecondary,
          ),
          const SizedBox(height: 8),
          Obx(
            () => AppTextField(
              controller: controller.registerPasswordController,
              hintText: 'Masukkan password',
              obscureText: controller.isPasswordRegisterVisible.value,
              passwordChar: '*',
              keyboardType: TextInputType.visiblePassword,
              showPasswordToggle: true,
              onTogglePassword: () => controller.togglePasswordRegister(),
            ),
          ),
          const SizedBox(height: 24),
          Obx(
            () => AppFilledButton(
              onPressed: controller.isRegisterValid.value
                  ? controller.register
                  : null,
              text: 'Daftar',
              height: 56,
              textSize: 16,
              disabledForegroundColor: context.colorScheme.textOnSecondary,
              color: controller.isRegisterValid.value
                  ? context.colorScheme.primary
                  : context.colorScheme.borderPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSplashContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 115,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [context.colorScheme.accent, context.colorScheme.surface],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Center(
            child: Image.asset(
              AppImages.kaujeLogo,
              width: double.infinity,
              height: 56,
            ),
          ),
        ),
      ),
    );
  }
}
