import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cartlist/presentation/widgets/card_list_builder.dart';
import 'package:flutter/material.dart';

class CardlistView extends StatelessWidget {
  const CardlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart", style: TextStyles.textStyle20),
        centerTitle: true,
      ),
      body: CardListBuilder(),
    );
  }
}
