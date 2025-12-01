import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/widgets/empty_list_widget.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/dismiss_wish_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class WishListBuilder extends StatelessWidget {
  const WishListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<WishlistCubit>();
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is SucceededState) {
          if (cubit.wishList.isEmpty) {
            return EmptyListWidget(
              text: "Empty List",
              image: AppImages.bookmarkSvg,
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(22),
              separatorBuilder: (context, i) =>
                  Divider(color: Color(0xffF0F0F0)),

              itemCount: cubit.wishList.length,
              itemBuilder: (context, i) {
                return DismissWishCard(wishmodel: cubit.wishList[i]);
              },
            );
          }
        } else if (state is FailureStates) {
          return Center(child: Text(state.message ?? ""));
        } else {
          return Center(child: Lottie.asset('assets/images/Open book.json'));
        }
      },
    );
  }
}
