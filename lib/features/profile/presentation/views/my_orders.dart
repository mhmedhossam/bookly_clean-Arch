import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/empty_list_widget.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Gap(10), CustomBackButton()],
        ),
        title: Text("My Orders", style: TextStyles.textStyle20),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          var orders = cubit.orders;
          if (state is ProfileSuccessState) {
            if (cubit.orders!.isNotEmpty) {
              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return CustomOrderWidget(
                      orderDate: orders?[i].orderDate ?? "",
                      orderTitle: orders?[i].orderCode ?? "",
                      total: orders?[i].total ?? "",
                    );
                  },
                  itemCount: orders?.length,
                ),
              );
            } else {
              return EmptyListWidget(
                text: "No Orders yet ",
                image: AppImages.cartSvg,
              );
            }
          } else if (state is ProfileLoadingState) {
            return LottieBuilder.asset(AppImages.loadingIndicator);
          } else if (state is ProfileFailureState) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class CustomOrderWidget extends StatelessWidget {
  final String orderTitle;
  final String orderDate;
  final String total;
  const CustomOrderWidget({
    super.key,
    required this.orderTitle,
    required this.orderDate,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Order No$orderTitle",
                  style: TextStyles.textStyle16.copyWith(
                    color: AppColors.darkColor,
                  ),
                  maxLines: 1,
                ),
              ),
              Flexible(
                child: Text(
                  orderDate,
                  style: TextStyles.textStyle14.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: TextStyles.textStyle16.copyWith(
                  color: AppColors.darkGreyColor,
                ),

                children: [
                  TextSpan(text: "Total Amount: "),
                  TextSpan(
                    text: "\$$total",
                    style: TextStyles.textStyle16.copyWith(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
