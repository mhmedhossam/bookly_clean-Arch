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
import 'package:bookia/features/home/presentation/widgets/book_details_component.dart';
import 'package:bookia/features/home/presentation/widgets/bottom_nav_add_to_cart.dart';
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
        bottomNavigationBar: BottomNavAddToCart(product: product),
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
            child: BookDetailsComponent(source: source, product: product),
          ),
        ),
      ),
    );
  }
}
