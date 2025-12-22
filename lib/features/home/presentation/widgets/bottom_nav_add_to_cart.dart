import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavAddToCart extends StatelessWidget {
  const BottomNavAddToCart({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("\$${product?.price ?? 0}", style: TextStyles.textStyle24),
            MainButton(
              onPressed: () {
                context.read<HomeCubit>().addToCartList(product?.id ?? 0);
              },
              bgColor: AppColors.darkColor,
              height: 56,
              width: 242,

              text: "Add to Cart",
              size: 20,
              textColor: AppColors.backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
