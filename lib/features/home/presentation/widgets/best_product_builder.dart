import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BestProductBuilder extends StatelessWidget {
  final List<Product> productList;

  const BestProductBuilder({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Best Seller",
            style: TextStyles.textStyle24.copyWith(fontWeight: FontWeight.w400),
          ),
        ),

        Gap(20),
        SizedBox(
          height: 310,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BookCard(
                  product: productList[i],
                  source: "best",
                  tag: "best_${productList[i].id ?? ""}",
                ),
              );
            },
            itemCount: productList.length,
          ),
        ),
      ],
    );
  }
}
