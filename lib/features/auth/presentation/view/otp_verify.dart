import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/cubit/authstates.dart';
import 'package:bookia/features/auth/presentation/cubit/authtcubit.dart';
import 'package:bookia/features/auth/presentation/widgets/custom_navigation_bar_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class OtpVerify extends StatelessWidget {
  final String email;
  const OtpVerify({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<Authtcubit>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      bottomNavigationBar: CustomNavigationBarTextButton(
        text: "Didn’t received code?  ",
        buttonText: "Resend",
        textButtonOnTap: () {},
      ),
      body: BlocListener<Authtcubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthSucceeded) {
            Navigation.pop(context);
            Navigation.pushNamedTo(
              context,
              Routes.createNewPassScreen,
              cubit.otpController.text,
            );
          } else if (state is AuthLoading) {
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
              key: cubit.formKey,
              child: Column(
                children: [
                  Text("OTP Verification ", style: TextStyles.textStyle30),
                  Text(
                    "Enter the verification code we just sent on your email address.",
                    style: TextStyles.textStyle16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Gap(20),
                  Pinput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter otp";
                      }
                      return null;
                    },
                    controller: cubit.otpController,
                    length: 6,
                    focusedPinTheme: PinTheme(
                      width: 80,
                      height: 60,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffBFA054), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: 80,
                      height: 60,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffF7F8F9),

                        border: Border.all(color: Color(0xffE8ECF4), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Gap(20),

                  MainButton(
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.otpVerify(email);
                      }
                    },
                    text: "verify",
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
