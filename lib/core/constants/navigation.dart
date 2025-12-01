import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static pushReplacementNamed(
    BuildContext context,
    String screenPage, [
    Object? extra,
  ]) {
    return context.pushReplacement(screenPage);
  }

  static Future pushNamedTo(
    BuildContext context,
    String screenPage, [
    Object? extra,
  ]) {
    return context.push(screenPage, extra: extra);
  }

  static pushNamedandRemoveUntilTo(
    BuildContext context,
    String screenPage, [
    Object? extra,
  ]) {
    return context.go(screenPage, extra: extra);
  }

  static pop(BuildContext context, [dynamic a]) {
    if (context.canPop()) {
      return context.pop(a);
    }
  }
}
