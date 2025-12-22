import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';

class SearchResultBuilder extends StatelessWidget {
  const SearchResultBuilder({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
        mainAxisExtent: 300,
      ),
      itemCount: cubit.searchProduct.length,
      itemBuilder: (context, i) {
        return BookCard(
          product: cubit.searchProduct[i],
          tag: "search_${cubit.searchProduct[i].id}",
          source: "search",
        );
      },
    );
  }
}
