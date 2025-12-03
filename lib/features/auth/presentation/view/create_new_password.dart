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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class CreateNewPassword extends StatelessWidget {
  final String otp;
  const CreateNewPassword({super.key, required this.otp});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<Authtcubit>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      body: BlocListener<Authtcubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showloadingDialog(context);
          } else if (state is AuthSucceeded) {
            context.pop();
            Navigation.pushNamedandRemoveUntilTo(
              context,
              Routes.passChangedScreen,
            );
          } else if (state is AuthFailure) {
            context.pop();
            showMyDialog(context, state.errorMessage);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Text("Create new password ", style: TextStyles.textStyle30),
                  Text(
                    "Your new password must be unique from those previously used.",
                    style: TextStyles.textStyle16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  CustomTextField(
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
                  CustomTextField(
                    controller: cubit.confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      } else if (value != cubit.passwordController.text) {
                        return "the confirm password is tha same password";
                      }
                      return null;
                    },
                    hintText: 'Enter your password',
                  ),
                  Gap(13),
                  MainButton(
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.setNewPassword(otp);
                      }
                    },
                    text: "Reset Password",
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
