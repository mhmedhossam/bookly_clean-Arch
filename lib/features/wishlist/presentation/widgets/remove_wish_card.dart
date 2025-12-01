import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RemoveWishCard extends StatelessWidget {
  const RemoveWishCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            AppImages.xIconSvg,
            colorFilter: ColorFilter.mode(
              AppColors.backgroundColor,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
          Gap(10),
        ],
      ),
    );
  }
}
