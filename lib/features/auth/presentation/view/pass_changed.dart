import 'package:bookia/core/constants/routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_succeed_widget.dart';

// ignore: must_be_immutable
class PassChanged extends StatefulWidget {
  String? token;
  PassChanged({super.key, this.token});

  @override
  State<PassChanged> createState() => _PassChangedState();
}

class _PassChangedState extends State<PassChanged> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSucceedWidget(
        title: "Password Changed!",
        subTitle: "Your password has been Changed",
        subTitle2: "successfuly",
        textButton: "Back to Login",
        screenPage: Routes.loginScreen,
      ),
    );
  }
}
