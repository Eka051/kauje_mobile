import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/entypo.dart';
import 'package:kauje_mobile/app/constants/app_const.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppImages.kaujeLogo, width: 150, height: 150),
        IconButton(icon: Iconify(Entypo.bell, size: 32), onPressed: () {}),
      ],
    );
  }
}