import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/cartlist/data/repo/cardlist_repo.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';
import 'package:bookia/features/home/domain/entities/slider_model/slider.dart';
import 'package:bookia/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_b_seller_p_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_search_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_slider_usecase.dart';
import 'package:bookia/features/home/presentation/cubit/home_states.dart';
import 'package:bookia/features/wishlist/data/repo/wish_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  List<SliderModel> sliders = [];
  List<Product> bestProducts = [];
  List<Product> products = [];
  List<Product> searchProduct = [];

  GetSliderUseCase getSliderUseCase;
  GetSearchUseCase getSearchUseCase;
  GetBSellerPUseCase getBSellerPUseCase;
  GetAllProductUseCase getAllProductUseCase;
  final searchController = TextEditingController();
  HomeCubit({
    required this.getAllProductUseCase,
    required this.getBSellerPUseCase,
    required this.getSearchUseCase,
    required this.getSliderUseCase,
  }) : super(InitialState());

  getHome() async {
    emit(HomeLoading());
    if (isClosed) return;

    final response = await Future.wait([
      getSliderUseCase.call(),
      getBSellerPUseCase.call(),
      getAllProductUseCase.call(),
    ]);
    if (isClosed) return;

    final sliderRes = response[0] as Either<Failure, HomeSliderModel>;
    final bestSellerRes = response[1] as Either<Failure, ProductModel>;
    final productRes = response[2] as Either<Failure, ProductModel>;

    if (sliderRes.isLeft()) {
      emit(HomeFailure(message: sliderRes.getLeft().errorMessage));

      return;
    } else {
      sliders = sliderRes.getRight().sliders ?? [];
    }

    if (bestSellerRes.isLeft()) {
      emit(HomeFailure(message: bestSellerRes.getLeft().errorMessage));
      return;
    } else {
      bestProducts = bestSellerRes.getRight().products ?? [];
    }

    if (productRes.isLeft()) {
      emit(HomeFailure(message: productRes.getLeft().errorMessage));
      return;
    } else {
      products = productRes.getRight().products ?? [ ] ;
    }
    emit(HomeSucceed());

    //
  }

  search() async {
    emit(HomeLoading());
    if (isClosed) return;
    var res = await getSearchUseCase.call(searchController.text);

    if (res.isLeft()) {
      emit(HomeFailure(message: res.getLeft().errorMessage));
    } else {
      searchProduct = res.getRight().products ?? [];
      emit(HomeSucceed());
    }
  }

  addToWishList(int id) async {
    if (isClosed) return;

    var res = await WishRepo.addToWishList(id);
    if (isClosed) return;

    if (res.status != 200) {
      emit(HomeFailure(message: res.message ?? ""));
    } else {
      emit(HomeSucceed(message: "product added to WishList"));
    }
  }

  addToCartList(int id) async {
    if (isClosed) return;

    var res = await CardlistRepo.addToCart(id);
    if (isClosed) return;

    if (res.status != 201) {
      emit(HomeFailure(message: res.message ?? ""));
    } else {
      emit(HomeSucceed(message: "product added to Cart successfully"));
    }
  }
}
