import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum Dialogtype { success, error, info }

showMyDialog(
  BuildContext context,
  String message, [
  Dialogtype type = Dialogtype.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type == Dialogtype.error
          ? AppColors.error
          : type == Dialogtype.success
          ? AppColors.primaryColor
          : AppColors.darkGreyColor,
    ),
  );
}

showloadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(child: Lottie.asset('assets/images/Open book.json'));
    },
  );
}
