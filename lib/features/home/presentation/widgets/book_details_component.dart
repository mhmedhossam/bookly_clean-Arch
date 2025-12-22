import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:html/parser.dart' as html_parser;

class BookDetailsComponent extends StatelessWidget {
  const BookDetailsComponent({
    super.key,
    required this.source,
    required this.product,
  });

  final String? source;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "${source}_${product?.id ?? ""}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: product?.image ?? "",
                height: 270,
                width: 183,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(20),
          SizedBox(
            width: 247,
            height: 78,
            child: Text(
              product?.name ?? "",
              style: TextStyles.textStyle30,
              maxLines: 2,

              textAlign: TextAlign.center,
            ),
          ),
          Gap(10),
          Text(
            product?.category ?? "",
            style: TextStyles.textStyle14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            html_parser.parse(product?.description ?? "").body!.text,
            style: TextStyles.textStyle14,
            textAlign: TextAlign.justify,
          ),
          Gap(MediaQuery.of(context).size.width * 0.19),
        ],
      ),
    );
  }
}
