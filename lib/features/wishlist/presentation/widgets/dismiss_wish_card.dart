import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/product.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/widgets/remove_wish_card.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wish_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DismissWishCard extends StatelessWidget {
  final Product wishmodel;

  @override
  const DismissWishCard({super.key, required this.wishmodel});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<WishlistCubit>().removeFromWishList(wishmodel.id!);
      },
      background: RemoveWishCard(),

      key: UniqueKey(),
      child: WishCard(wishmodel: wishmodel),
    );
  }
}
