import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/cubit/authstates.dart';
import 'package:bookia/features/auth/presentation/cubit/authtcubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool isObSecureCurrent = true;
  bool isObSecureNPass = true;
  bool isObSecureConfirmNpass = true;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      body: BlocListener<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            showloadingDialog(context);
          } else if (state is ProfileSuccessState) {
            context.pop();
            showMyDialog(context, "Password changed Successfully");
          } else if (state is ProfileFailureState) {
            context.pop();
            showMyDialog(context, "");
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(22.0),
            child: Form(
              key: cubit.formkey,
              child: Column(
                children: [
                  Text("New password ", style: TextStyles.textStyle30),
                  Gap(70),

                  CustomTextField(
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObSecureCurrent = !isObSecureCurrent;
                        setState(() {});
                      },
                      icon: isObSecureCurrent
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.5,
                              ),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.5,
                              ),
                            ),
                    ),
                    obscureText: isObSecureCurrent,
                    controller: cubit.currentPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      }
                      return null;
                    },
                    hintText: 'Current password',
                  ),
                  Gap(20),

                  CustomTextField(
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObSecureNPass = !isObSecureNPass;
                        setState(() {});
                      },
                      icon: isObSecureNPass
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.5,
                              ),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.5,
                              ),
                            ),
                    ),
                    obscureText: isObSecureNPass,
                    controller: cubit.newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      }
                      return null;
                    },
                    hintText: 'New password',
                  ),
                  Gap(20),
                  CustomTextField(
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObSecureConfirmNpass = !isObSecureConfirmNpass;
                        setState(() {});
                      },
                      icon: isObSecureConfirmNpass
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.5,
                              ),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.darkGreyColor.withValues(
                                alpha: 0.5,
                              ),
                            ),
                    ),
                    controller: cubit.confirmNewPasswordController,
                    obscureText: isObSecureConfirmNpass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      } else if (value != cubit.newPasswordController.text) {
                        return "the confirm password is tha same password";
                      }
                      return null;
                    },
                    hintText: 'Confirm password',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: MainButton(
            onPressed: () {
              if (cubit.formkey.currentState!.validate()) {
                showloadingDialog(context);
                Future.delayed(Duration(seconds: 3), () {
                  Navigation.pop(context);
                  showMyDialog(
                    context,
                    "password change succefully",
                    Dialogtype.success,
                  );
                  Navigation.pop(context);
                });
              }
            },
            text: "Update Password",
            bgColor: AppColors.primaryColor,
            textColor: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}
