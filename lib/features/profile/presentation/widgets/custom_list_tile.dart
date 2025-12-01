import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const CustomListTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withValues(alpha: 0.1),
            spreadRadius: 0.1,
            blurRadius: 10,
            offset: Offset(1, 9),
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        onTap: onTap,

        title: Text(title),

        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
