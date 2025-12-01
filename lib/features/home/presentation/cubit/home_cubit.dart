import 'package:bookia/features/cartlist/data/repo/cardlist_repo.dart';
import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/all_product_model.dart';
import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/product.dart';
import 'package:bookia/features/home/data/models/response/slider_model/home_model.dart';
import 'package:bookia/features/home/data/models/response/slider_model/slider.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_states.dart';
import 'package:bookia/features/wishlist/data/repo/wish_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  List<SliderModel> sliders = [];
  List<Product> bestProducts = [];
  List<Product> products = [];
  List<Product> searchProduct = [];
  final searchController = TextEditingController();
  HomeCubit() : super(InitialState());

  getHome() async {
    try {
      emit(HomeLoading());
      if (isClosed) return;

      final response = await Future.wait([
        HomeRepo.getSlider(),
        HomeRepo.getBestSellerPduct(),
        HomeRepo.getAllProduct(),
      ]);
      if (isClosed) return;

      final sliderRes = response[0] as HomeModel;
      final bestSellerRes = response[1] as ProductsModel;
      final productRes = response[2] as ProductsModel;

      if (sliderRes.status != 200) {
        emit(
          HomeFailure(message: sliderRes.message ?? "error try again later"),
        );
        return;
      }
      if (bestSellerRes.status != 200) {
        emit(
          HomeFailure(
            message: bestSellerRes.message ?? " error try again later",
          ),
        );
        return;
      }
      if (productRes.status != 200) {
        emit(
          HomeFailure(message: productRes.message ?? " error try again later"),
        );
        return;
      }
      sliders = sliderRes.data?.sliders ?? [];
      bestProducts = bestSellerRes.data?.products ?? [];
      products = productRes.data?.products ?? [];

      emit(HomeSucceed());
    } catch (e) {
      emit(HomeFailure(message: "error please try again later"));
    }
  }

  serch() async {
    emit(HomeLoading());
    if (isClosed) return;
    var res = await HomeRepo.getSearch(searchController.text);
    if (res.status != 200) {
      emit(HomeFailure(message: res.message ?? ""));
    } else {
      emit(HomeSucceed());
      searchProduct = res.data?.products ?? [];
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
