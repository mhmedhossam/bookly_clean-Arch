import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Product product;
  final Object tag;
  final String source;
  const BookCard({
    super.key,
    required this.product,
    required this.tag,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.pushNamedTo(context, Routes.detailsScreen, {
          "product": product,
          "source": source,
        });
      },
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: product.image!,
                    fit: BoxFit.cover,
                    height: 170,
                    width: 145,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  product.name!,
                  style: TextStyles.textStyle18.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.price!, style: TextStyles.textStyle16),
                  MainButton(
                    bgColor: AppColors.darkColor,
                    height: 27,
                    width: 75,

                    text: "buy",
                    textColor: AppColors.backgroundColor,
                    onPressed: () {
                      Navigation.pushNamedTo(context, Routes.detailsScreen, {
                        "product": product,
                        "source": source,
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
