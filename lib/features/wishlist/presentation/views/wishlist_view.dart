import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../widgets/wish_list_builder.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist", style: TextStyles.textStyle20),
        centerTitle: true,
      ),
      body: WishListBuilder(),
    );
  }
}
