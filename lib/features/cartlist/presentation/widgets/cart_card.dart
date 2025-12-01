import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialog.dart';
import 'package:bookia/features/cartlist/data/models/response/card_list_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class CartCard extends StatelessWidget {
  final VoidCallback onRemove;
  final Function(int) increase;
  final Function(int) decrease;
  int x = 1;
  final CartItem cartModel;

  CartCard({
    super.key,
    required this.cartModel,
    required this.onRemove,
    required this.increase,
    required this.decrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.backgroundColor.withValues(alpha: 0.2),
      ),
      width: double.infinity,
      height: 145,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: cartModel.itemProductImage ?? "",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        cartModel.itemProductName ?? "",
                        style: TextStyles.textStyle18,
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: onRemove,

                      icon: SvgPicture.asset(
                        AppImages.xIconSvg,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        "\$ ${cartModel.itemProductPriceAfterDiscount?.toStringAsFixed(2)}",
                        style: TextStyles.textStyle16,
                        maxLines: 1,
                      ),
                      Gap(20),
                      Text(
                        "\$ ${cartModel.itemProductPrice}" ?? "",
                        style: TextStyles.textStyle16.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((cartModel.itemQuantity ?? 0) <
                            (cartModel.itemProductStock ?? 0)) {
                          int newQuantity = (cartModel.itemQuantity ?? 0) + 1;
                          increase(newQuantity);
                        } else {
                          showMyDialog(
                            context,
                            "the maximum quantity is ${cartModel.itemProductStock ?? 0}",
                            Dialogtype.info,
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.withValues(alpha: 0.2),

                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                    Text(
                      cartModel.itemQuantity.toString().padLeft(2, '0'),
                      style: TextStyles.textStyle18,
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((cartModel.itemQuantity ?? 0) > 1) {
                          int newQuantity = (cartModel.itemQuantity ?? 0) - 1;
                          decrease(newQuantity);
                        } else {
                          showMyDialog(
                            context,
                            "Minimum quantity is 1",
                            Dialogtype.info,
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 15, 0),

                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.withValues(alpha: 0.2),

                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),
                    // Spacer(),
                    Flexible(
                      child: cartModel.itemTotal is double
                          ? Text(
                              (cartModel.itemTotal as double).toStringAsFixed(
                                2,
                              ),

                              style: TextStyles.textStyle18,
                              maxLines: 1,
                            )
                          : cartModel.itemTotal is String
                          ? Text(
                              double.parse(
                                cartModel.itemTotal as String,
                              ).toStringAsFixed(2),
                              maxLines: 1,
                            )
                          : Text(
                              (cartModel.itemTotal as int).toStringAsFixed(2),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
