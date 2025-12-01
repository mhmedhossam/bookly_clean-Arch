import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomSucceedWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String subTitle2;
  final String textButton;
  final String screenPage;
  const CustomSucceedWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.subTitle2,
    required this.textButton,
    required this.screenPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/successimage.svg",
            width: 100,
            height: 100,
          ),
          Gap(20),
          Text(
            title,
            style: TextStyles.textStyle24.copyWith(color: AppColors.darkColor),
          ),
          Text(
            subTitle,
            style: TextStyles.textStyle15.copyWith(color: AppColors.greyColor),
          ),
          Text(
            subTitle2,
            style: TextStyles.textStyle15.copyWith(color: AppColors.greyColor),
          ),
          Gap(40),
          MainButton(
            text: textButton,
            textColor: AppColors.backgroundColor,

            // labelwidget: TextWidget(text: "Back to Login", size: 15),
            bgColor: AppColors.primaryColor,

            onPressed: () {
              Navigation.pushNamedandRemoveUntilTo(context, screenPage, 0);
            },
          ),
        ],
      ),
    );
  }
}
