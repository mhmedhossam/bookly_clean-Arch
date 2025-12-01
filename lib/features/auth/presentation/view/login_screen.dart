import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/cubit/authstates.dart';
import 'package:bookia/features/auth/presentation/cubit/authtcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../widgets/custom_navigation_bar_text_button.dart';
import '../widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      bottomNavigationBar: CustomNavigationBarTextButton(
        text: "Don’t have an account?",
        buttonText: "Register Now",
        textButtonOnTap: () {
          Navigation.pushReplacementNamed(context, Routes.registerScreen);
        },
      ),
      body: BlocListener<Authtcubit, Authstates>(
        listener: (context, state) {
          if (state is Authloading) {
            showloadingDialog(context);
          } else if (state is AuthFailure) {
            Navigation.pop(context);

            showMyDialog(context, state.errorMessage);
          } else if (state is AuthSuccessed) {
            Navigation.pop(context);
            Navigation.pushNamedandRemoveUntilTo(context, Routes.mainAppScreen);
          }
        },
        child: _loginBody(context),
      ),
    );
  }
}

_loginBody(BuildContext context) {
  var cubit = context.read<Authtcubit>();
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(22.0),
      child: Form(
        key: cubit.formkey,
        child: Column(
          children: [
            Text(
              "Welcome back! Glad to see you, Again! ",
              style: TextStyles.textStyle30,
            ),
            Gap(32),
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your email";
                } else if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                ).hasMatch(value)) {
                  return "please enter a valid email";
                }
                return null;
              },
              controller: cubit.emailController,
              hintText: "Enter your email",
            ),
            Gap(15),

            CustomTextField(
              obscureText: true,
              controller: cubit.passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter your password";
                }
                return null;
              },
              hintText: 'Enter your password',
            ),
            Gap(13),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigation.pushNamedTo(
                      context,
                      Routes.forgetPasswordScreen,
                    );
                  },
                  child: Text("Forget Password", style: TextStyles.textStyle14),
                ),
              ],
            ),
            Gap(30),

            MainButton(
              onPressed: () {
                if (cubit.formkey.currentState!.validate()) {
                  context.read<Authtcubit>().login();
                }
              },
              text: "Login",
              bgColor: AppColors.primaryColor,
              textColor: AppColors.backgroundColor,
            ),
            Gap(34),
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.borderColor)),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 47,
                    right: 47,
                    top: 34,
                    bottom: 27,
                  ),
                  child: Text(
                    "Or",
                    style: TextStyles.textStyle14.copyWith(
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.borderColor)),
              ],
            ),

            SocialButton(
              image: AppImages.googleIconSvg,
              text: "Sign in with Google",
              onPressed: () {},
            ),
            Gap(15),
            SocialButton(
              image: AppImages.cibAppleSvg,
              text: "Sign in with Apple",
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
