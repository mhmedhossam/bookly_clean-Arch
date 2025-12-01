import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialButton extends StatelessWidget {
  final Function() onPressed;
  final String image;
  final String text;
  const SocialButton({
    super.key,
    required this.onPressed,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColors.borderColor),
        ),
        width: double.infinity,
        height: 56,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(image),
              Gap(9),
              Text(
                text,
                style: TextStyles.textStyle14.copyWith(
                  color: AppColors.darkGreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
