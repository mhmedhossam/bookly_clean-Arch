import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/cubit/authstates.dart';
import 'package:bookia/features/auth/presentation/cubit/authtcubit.dart';
import 'package:bookia/features/auth/presentation/widgets/custom_navigation_bar_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<Authtcubit>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      bottomNavigationBar: CustomNavigationBarTextButton(
        text: "Remember Password? ",
        buttonText: "Login",
        textButtonOnTap: () {
          Navigation.pop(context);
        },
      ),
      body: BlocListener<Authtcubit, Authstates>(
        listener: (context, state) {
          if (state is AuthSuccessed) {
            Navigation.pop(context);
            Navigation.pushNamedTo(
              context,
              Routes.otpVerifyScreen,
              cubit.emailController.text,
            );
          } else if (state is Authloading) {
            showloadingDialog(context);
          } else if (state is AuthFailure) {
            Navigation.pop(context);
            showMyDialog(context, state.errorMessage);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Form(
              key: cubit.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Forgot Password? ", style: TextStyles.textStyle30),
                  Gap(10),
                  Text(
                    "Don't worry! It occurs. Please enter the email address linked with your account. ",
                    style: TextStyles.textStyle16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Gap(30),

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
                  Gap(38),

                  MainButton(
                    onPressed: () async {
                      if (cubit.formkey.currentState!.validate()) {
                        await cubit.fogetPassword();
                      }
                    },
                    text: "Send Code",
                    bgColor: AppColors.primaryColor,
                    textColor: AppColors.backgroundColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
