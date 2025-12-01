import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/widgets/custom_succeed_widget.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSucceedWidget(
        title: "SUCCESS!",
        subTitle: "Your order will be delivered soon.",
        subTitle2: "Thank you for choosing our app!",
        textButton: "Back To Home",
        screenPage: Routes.mainAppScreen,
      ),
    );
  }
}
