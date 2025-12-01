import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomNavigationBarTextButton extends StatelessWidget {
  final String text;
  final String buttonText;
  final Function() textButtonOnTap;

  const CustomNavigationBarTextButton({
    super.key,
    required this.text,
    required this.buttonText,
    required this.textButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyles.textStyle14.copyWith(color: AppColors.darkColor),
          ),
          TextButton(
            onPressed: textButtonOnTap,
            child: Text(
              buttonText,
              style: TextStyles.textStyle14.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
