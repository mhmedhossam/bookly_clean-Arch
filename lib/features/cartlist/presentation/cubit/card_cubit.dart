import 'dart:developer';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/user.dart';
import 'package:bookia/features/cartlist/data/models/response/card_list_response/card_list_response.dart';
import 'package:bookia/features/cartlist/data/models/response/card_list_response/cart_item.dart';
import 'package:bookia/features/cartlist/data/models/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/data/repo/cardlist_repo.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CardListResponse? cardListResponse;
  List<CartItem> cartItem = [];

  var name = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var governorate = TextEditingController();
  int? governorateId;
  CartCubit() : super(CartInitialState());

  getCart() async {
    emit(CartLoadingState());

    var res = await CardlistRepo.getCartList();
    if (isClosed) return;

    if (res.status != 200) {
      emit(CartFailureState(message: res.message));
    } else {
      cardListResponse = res;
      cartItem = res.data?.cartItems ?? [];
      emit(CartSucceedState());
    }
  }

  removeCart(int id) async {
    if (isClosed) return;

    var res = await CardlistRepo.removeFromCart(id);
    if (res.status != 200) {
      emit(CartFailureState(message: res.message));
    } else {
      cardListResponse = res;
      cartItem = res.data?.cartItems ?? [];

      emit(CartSucceedState());
    }
  }

  updateCart({required int id, required int quantity}) async {
    if (isClosed) return;

    var res = await CardlistRepo.updateItemCart(id: id, quantity: quantity);
    if (isClosed) return;

    if (res.status != 201) {
      emit(CartFailureState(message: res.message));
    } else {
      cardListResponse = res;
      cartItem = res.data?.cartItems ?? [];
      emit(CartSucceedState());
    }
  }

  checkOut() async {
    emit(CheckoutLoadingState());

    var res = await CardlistRepo.checkOutRepo();
    if (isClosed) return;

    if (res.status != 200) {
      emit(CheckoutFailureState(message: res.message));
    } else {
      emit(CheckoutSucceedState());
    }
  }

  submitOrder(User user) async {
    try {
      if (isClosed) return;
      emit(PlaceOrderLoadingState());
      var res = await CardlistRepo.submitOrder(user);
      if (isClosed) return;

      if (res.status != 201) {
        emit(PlaceOrderFailureState(message: res.message));
      } else {
        emit(PlaceOrderSucceedState());
      }
    } on Exception catch (e) {
      log(e.toString());
      throw (e.toString());
    }
  }

  reFillDataUser() {
    var user = SharedPref.getUserData() as AuthUSer;

    email.text = user.email ?? "";
    phone.text = user.phone ?? "";
    address.text = user.address ?? "";
    name.text = user.name ?? "";
  }
}
