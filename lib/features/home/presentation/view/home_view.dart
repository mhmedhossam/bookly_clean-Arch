import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/navigation.dart';
import 'package:bookia/core/constants/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_states.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../widgets/best_product_builder.dart';
import '../widgets/all_product.dart';
import '../widgets/home_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigation.pushNamedTo(context, Routes.searchScreen);
              //for logout not here
              // SharedPref.detete("token");
              // if (SharedPref.getToken() == null) {
              //   Navigation.pushNamedandRemoveUntilTo(
              //     context,
              //     Routes.welcomeScreen,
              //   );
              // }
            },
            icon: SvgPicture.asset(AppImages.searchNormalSvg),
          ),
        ],
        title: SvgPicture.asset(
          "assets/images/logo 2.svg",
          height: 30,
          width: 99,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();

          if (state is HomeSucceed) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeSlider(sliders: cubit.sliders),

                    Gap(20),
                    BestProductBuilder(productList: cubit.bestProducts),
                    Gap(20),

                    AllProductBuilder(productList: cubit.products),
                  ],
                ),
              ),
            );
          } else if (state is HomeFailure) {
            return Center(child: Text(state.message ?? ""));
          } else {
            return Center(child: Lottie.asset('assets/images/Open book.json'));
          }
        },
      ),
    );
  }
}
