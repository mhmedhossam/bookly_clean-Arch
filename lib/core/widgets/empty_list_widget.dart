import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  final String image;
  const EmptyListWidget({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 120,
            width: 120,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor.withValues(alpha: 0.2),
              BlendMode.srcIn,
            ),
          ),

          Text(
            text,
            style: TextStyles.textStyle30.copyWith(color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
