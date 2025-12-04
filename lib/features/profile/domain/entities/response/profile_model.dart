import 'package:flutter/material.dart';

class ProfileModel {
  final String title;

  final Function() onTap;

  ProfileModel({required this.onTap, required this.title});
}
