import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_cubit.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_states.dart';
import 'package:bookia/features/cartlist/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/empty_list_widget.dart';

class CardListBuilder extends StatelessWidget {
  const CardListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();

    return BlocConsumer<CartCubit, CartStates>(
      buildWhen: (previous, current) =>
          current is CartSucceedState ||
          current is CartLoadingState ||
          current is CartFailureState,
      listener: (context, state) {
        if (state is CheckoutLoadingState) {
          showloadingDialog(context);
        } else if (state is CheckoutFailureState) {
          Navigation.pop(context);

          showMyDialog(context, state.message ?? "error", Dialogtype.error);
        } else if (state is CheckoutSucceedState) {
          Navigation.pop(context);
          Navigation.pushNamedTo(
            context,
            Routes.placeYOrder,
            cubit.cartModel?.total,
          );
        }
      },
      builder: (context, state) {
        if (state is CartSucceedState) {
          if (cubit.cartItem.isEmpty) {
            return EmptyListWidget(
              text: "Empty Cart",
              image: AppImages.cartSvg,
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(22),
                    separatorBuilder: (context, i) =>
                        Divider(color: Color(0xffF0F0F0)),

                    itemCount: cubit.cartItem.length,
                    itemBuilder: (context, i) {
                      return CartCard(
                        decrease: (newquantity) {
                          cubit.updateCart(
                            id: cubit.cartItem[i].itemId ?? 0,
                            quantity: newquantity,
                          );
                        },
                        increase: (newQuantity) {
                          cubit.updateCart(
                            id: cubit.cartItem[i].itemId ?? 0,
                            quantity: newQuantity,
                          );
                        },
                        cartModel: cubit.cartItem[i],
                        onRemove: () {
                          cubit.removeCart(cubit.cartItem[i].itemId ?? 0);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total", style: TextStyles.textStyle18),

                            cubit.cartModel?.total is double
                                ? Text(
                                    (cubit.cartModel?.total as double)
                                        .toStringAsFixed(2),

                                    style: TextStyles.textStyle18,
                                  )
                                : Text(
                                    double.parse(
                                      cubit.cartModel?.total as String,
                                    ).toStringAsFixed(2),
                                  ),
                          ],
                        ),
                      ),
                      Gap(20),
                      MainButton(
                        onPressed: () {
                          cubit.checkOut();
                        },
                        text: "Checkout",
                        bgColor: AppColors.primaryColor,
                        textColor: AppColors.backgroundColor,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        } else if (state is CartFailureState) {
          return Center(child: Text(state.message ?? ""));
        } else {
          return SizedBox.shrink();
          // return Center(child: Lottie.asset('assets/images/Open book.json'));
        }
      },
    );
  }
}
