import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            AppImages.welcome,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Spacer(flex: 2),
                SvgPicture.asset(AppImages.logoSvg),
                const Gap(25),
                Text(
                  "Order your Book now",
                  style: TextStyles.textStyle18.copyWith(
                    color: AppColors.darkColor,
                  ),
                ),
                Spacer(flex: 5),
                MainButton(
                  bgColor: AppColors.primaryColor,

                  textColor: AppColors.backgroundColor,
                  onPressed: () {
                    Navigation.pushNamedTo(context, Routes.loginScreen);
                  },
                  text: "Login",
                ),
                Gap(15),
                MainButton(
                  textColor: AppColors.darkColor,
                  borderColor: AppColors.darkColor,
                  bgColor: AppColors.backgroundColor,
                  onPressed: () {
                    Navigation.pushNamedTo(context, Routes.registerScreen);
                  },
                  text: "Register",
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
