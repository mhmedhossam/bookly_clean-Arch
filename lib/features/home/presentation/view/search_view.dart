import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_states.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatelessWidget {
  final con = TextEditingController();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: CustomBackButton(),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 5, 22, 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomTextField(
                  prefixIcon: Icon(Icons.search),
                  hintText: "search",
                  controller: cubit.searchController,
                  onChanged: (value) {
                    cubit.search();
                  },
                ),

                BlocBuilder<HomeCubit, HomeStates>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return SizedBox.shrink();
                    } else if (state is HomeSucceed) {
                      if (cubit.searchProduct.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text("no product in this word"),
                        );
                      }

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
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppImages.bookiaImg,
                              opacity: CurvedAnimation(
                                parent: AlwaysStoppedAnimation(0.2),
                                curve: Curves.bounceOut,
                              ),
                            ),

                            Text(
                              "Search to Find your Book",
                              style: TextStyles.textStyle24.copyWith(
                                color: AppColors.darkGreyColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
