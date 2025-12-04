import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_cubit.dart';
import 'package:bookia/features/cartlist/presentation/views/cardlist_view.dart';
import 'package:bookia/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_b_seller_p_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_search_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_slider_usecase.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/view/home_view.dart';
import 'package:bookia/features/profile/domain/usecases/get_my_orders_usecase.dart';
import 'package:bookia/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/views/profile_view.dart';
import 'package:bookia/features/wishlist/domain/usecases/add_to_wish_usecase.dart';
import 'package:bookia/features/wishlist/domain/usecases/get_wish_usecase.dart';
import 'package:bookia/features/wishlist/domain/usecases/remove_from_wish_usecase.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  int? initialIndex;
  MainAppScreen({super.key, this.initialIndex});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  late List<Widget> screens;
  @override
  void didUpdateWidget(covariant MainAppScreen oldWidget) {
    if (widget.initialIndex != null) {
      currentIndex = widget.initialIndex!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    screens = [
      BlocProvider(
        create: (context) => HomeCubit(
          addToWishUseCase: ServiceLocator.gi<AddToWishUseCase>(),

          getAllProductUseCase: ServiceLocator.gi<GetAllProductUseCase>(),
          getBSellerPUseCase: ServiceLocator.gi<GetBSellerPUseCase>(),
          getSearchUseCase: ServiceLocator.gi<GetSearchUseCase>(),
          getSliderUseCase: ServiceLocator.gi<GetSliderUseCase>(),
        )..getHome(),
        child: HomeScreen(),
      ),

      BlocProvider(
        create: (context) => WishlistCubit(
          getWishUseCase: ServiceLocator.gi<GetWishUseCase>(),
          removeFromWishUseCase: ServiceLocator.gi<RemoveFromWishUseCase>(),
        )..getWishList(),
        child: WishlistView(),
      ),
      BlocProvider(
        create: (context) => CartCubit()..getCart(),
        child: CardlistView(),
      ),
      BlocProvider(
        create: (context) => ProfileCubit(
          getMyOrdersUseCase: ServiceLocator.gi<GetMyOrdersUseCase>(),
          updateProfileUseCase: ServiceLocator.gi<UpdateProfileUseCase>(),
        ),
        child: ProfileView(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },

        items: [
          _bottonNavigationBarItem(asset: AppImages.homeIconSvg, label: "home"),
          _bottonNavigationBarItem(
            asset: AppImages.bookmarkSvg,
            label: "Bookmark",
          ),
          _bottonNavigationBarItem(asset: AppImages.cartSvg, label: "cart"),
          _bottonNavigationBarItem(
            asset: AppImages.profileSvg,
            label: "profile",
          ),
        ],
      ),

      body: screens[currentIndex],
    );
  }

  BottomNavigationBarItem _bottonNavigationBarItem({
    required String asset,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
      icon: SvgPicture.asset(asset),

      label: "home",
    );
  }
}
