import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:html/parser.dart' as html_parser;

class WishCard extends StatelessWidget {
  final Product wishmodel;

  const WishCard({super.key, required this.wishmodel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColor.withValues(alpha: 0.2),
      ),
      width: double.infinity,
      height: 145,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: wishmodel.image ?? "",
              fit: BoxFit.cover,
              height: 118,
              width: 100,
            ),
          ),
          Gap(20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wishmodel.name ?? "",
                  style: TextStyles.textStyle18,
                  maxLines: 1,
                ),
                Text(wishmodel.price ?? "", style: TextStyles.textStyle16),

                Text(
                  html_parser.parse(wishmodel.description ?? "").body!.text,
                  maxLines: 2,
                  style: TextStyles.textStyle14.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
