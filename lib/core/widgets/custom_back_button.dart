import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.pop(context);
      },
      child: SvgPicture.asset(AppImages.backSvg),
    );
  }
}
