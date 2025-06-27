import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import '../controllers/auth_controller.dart';
import '../../../theme/app_theme.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bgSplashscreen),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Image.asset(AppImages.welcomeLogo, width: 300, height: 300),
          ),
        ),
        _AnimatedAuthBottomSheet(),
      ],
    );
  }
}

class _AnimatedAuthBottomSheet extends StatefulWidget {
  @override
  State<_AnimatedAuthBottomSheet> createState() =>
      _AnimatedAuthBottomSheetState();
}

class _AnimatedAuthBottomSheetState extends State<_AnimatedAuthBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sheetAnimation;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _sheetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _tabController = TabController(length: 2, vsync: this);
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.62;
    return AnimatedBuilder(
      animation: _sheetAnimation,
      builder: (context, child) {
        if (_tabController == null) return const SizedBox.shrink();
        return Positioned(
          left: 0,
          right: 0,
          bottom: -sheetHeight + (sheetHeight * _sheetAnimation.value),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: sheetHeight,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Image.asset(
                      AppImages.kaujeLogo,
                      width: 120,
                      height: 56,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        TabBar(
                          controller: _tabController!,
                          labelColor: context.textColor,
                          unselectedLabelColor:
                              context.colorScheme.onSurfaceVariant,
                          indicator: BoxDecoration(
                            color: context.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              child: Text(
                                'Masuk',
                                style: AppThemeExtension(
                                  context,
                                ).textTheme.titleSmall,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Daftar',
                                style: AppThemeExtension(
                                  context,
                                ).textTheme.titleSmall,
                              ),
                            ),
                          ],
                          overlayColor: const WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          dividerColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController!,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: _LoginForm(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: _RegisterForm(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Login', style: AppThemeExtension(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        TextField(
          controller: controller.loginEmailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.loginPasswordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: controller.onLogin,
          child: const Text('Login'),
        ),
      ],
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Register',
          style: AppThemeExtension(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.registerEmailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.registerPasswordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: controller.onRegister,
          child: const Text('Register'),
        ),
      ],
    );
  }
}
