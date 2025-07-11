import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';
import 'package:kauje_mobile/app/theme/app_theme.dart';
import 'package:kauje_mobile/app/widgets/app_text_field.dart';
import 'package:kauje_mobile/app/widgets/header.dart';

import '../controllers/showcase_controller.dart';

class ShowcaseView extends GetView<ShowcaseController> {
  const ShowcaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.accent,
              context.colorScheme.surfaceContainerHighest,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.bgGradient,
                    fit: BoxFit.fitWidth,
                  ),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Header(),
                                      Transform.translate(
                                        offset: Offset(0, -30),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Get.toNamed('main');
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_back_rounded,
                                                  ),
                                                ),
                                                SizedBox(width: 32),
                                                Text(
                                                  'Produk & Jasa Alumni',
                                                  style: AppThemeExtension(
                                                    context,
                                                  ).textTheme.titleMedium,
                                                ),
                                              ],
                                            ),
                                            // content of the showcase view
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                  ),
                                              child: AppTextField(
                                                controller:
                                                    controller.searchController,
                                                hintText: 'Cari...',
                                                hintSize: 16,
                                                borderRadius: 14,
                                                // showBorder: false,
                                                suffixIcon: Icon(
                                                  Icons.search,
                                                  color: context
                                                      .colorScheme
                                                      .neutral,
                                                ),
                                              ),
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
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
