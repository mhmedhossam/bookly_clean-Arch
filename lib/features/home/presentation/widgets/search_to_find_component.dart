import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SearchToFindComponent extends StatelessWidget {
  const SearchToFindComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.bookiaImg,
            opacity: CurvedAnimation(
              parent: AlwaysStoppedAnimation(0.2),
              curve: Curves.bounceOut,
            ),
          ),

          Text(
            "Search to Find your Book",
            style: TextStyles.textStyle24.copyWith(
              color: AppColors.darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
