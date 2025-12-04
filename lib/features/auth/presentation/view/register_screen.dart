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

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      bottomNavigationBar: CustomNavigationBarTextButton(
        text: "Already have an account? ",
        buttonText: "Login Now",
        textButtonOnTap: () {
          Navigation.pushReplacementNamed(context, Routes.loginScreen);
        },
      ),
      body: _body(context),
    );
  }

  BlocListener<Authtcubit, AuthStates> _body(BuildContext context) {
    var cubit = context.read<Authtcubit>();

    return BlocListener<Authtcubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showloadingDialog(context);
        } else if (state is AuthFailure) {
          Navigation.pop(context);

          showMyDialog(context, state.errorMessage);
        } else if (state is AuthSucceeded) {
          Navigation.pop(context);

          Navigation.pushNamedTo(context, Routes.loginScreen);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(22),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello! Register to get started",
                  style: TextStyles.textStyle30,
                ),
                Gap(32),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter user name";
                    }
                    return null;
                  },
                  hintText: "Username",
                  controller: cubit.userNameController,
                ),
                Gap(15),

                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter email";
                    } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return "please enter a valid email";
                    }
                    return null;
                  },
                  hintText: "Email",
                  controller: cubit.emailController,
                ),
                Gap(15),

                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your password";
                    }
                    return null;
                  },
                  hintText: "password",
                  controller: cubit.passwordController,
                ),
                Gap(15),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your Confirm password";
                    } else if (cubit.confirmPasswordController.text !=
                        cubit.passwordController.text) {
                      return "the confirm password is not match with password";
                    }
                    return null;
                  },
                  hintText: "Confirm password",
                  controller: cubit.confirmPasswordController,
                ),
                Gap(30),

                MainButton(
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.register();
                    }
                  },
                  bgColor: AppColors.primaryColor,
                  width: double.infinity,
                  height: 57,
                  textColor: AppColors.backgroundColor,
                  text: "Register",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
