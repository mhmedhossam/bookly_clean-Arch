import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:html/parser.dart' as html_parser;

class DetailsScreen extends StatelessWidget {
  final Product? product;
  final String? source;
  const DetailsScreen({super.key, this.product, required this.source});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSucceed) {
          Navigation.pop(context);
          showMyDialog(context, state.message ?? "", Dialogtype.success);
        } else if (state is HomeFailure) {
          Navigation.pop(context);

          showMyDialog(
            context,
            state.message ?? "something error please try again",
          );
        } else {
          showloadingDialog(context);
        }
      },
      child: Scaffold(
        bottomNavigationBar: SafeArea(
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
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomBackButton(),
          actions: [
            IconButton(
              onPressed: () {
                context.read<HomeCubit>().addToWishList(product?.id ?? 0);
              },
              icon: SvgPicture.asset(AppImages.bookmarkSvg),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Center(
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
            ),
          ),
        ),
      ),
    );
  }
}
