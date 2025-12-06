import 'dart:developer';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/card_list_response.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/cart_item.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/domain/usecases/add_to_cart_use_case.dart';
import 'package:bookia/features/cartlist/domain/usecases/check_out_repo_use_case.dart';
import 'package:bookia/features/cartlist/domain/usecases/get_cart_list_use_case.dart';
import 'package:bookia/features/cartlist/domain/usecases/remove_from_cart.dart';
import 'package:bookia/features/cartlist/domain/usecases/submit_order_usecase.dart';
import 'package:bookia/features/cartlist/domain/usecases/update_item_cart_use_case.dart';
import 'package:bookia/features/cartlist/presentation/cubit/card_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  List<CartItem> cartItem = [];
  AddToCartUseCase addToCartUseCase;
  CartModel? cartModel;
  CheckOutUseCase checkOutUseCase;
  GetCartListUseCase getCartListUseCase;
  RemoveFromCart removeFromCart;
  SubmitOrderUseCase submitOrderUseCase;
  UpdateItemCartUseCase updateItemCartUseCase;
  var name = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var governorate = TextEditingController();
  int? governorateId;
  CartCubit({
    required this.addToCartUseCase,
    required this.checkOutUseCase,
    required this.getCartListUseCase,
    required this.removeFromCart,
    required this.submitOrderUseCase,
    required this.updateItemCartUseCase,
  }) : super(CartInitialState());

  getCart() async {
    emit(CartLoadingState());

    var res = await getCartListUseCase.call();
    if (isClosed) return;
    res.fold(
      (l) {
        emit(CartFailureState(message: l.errorMessage));
      },
      (r) {
        emit(CartSucceedState());
      },
    );
  }

  removeCart(int id) async {
    if (isClosed) return;

    var res = await removeFromCart.call(id);
    res.fold(
      (l) {
        emit(CartFailureState(message: l.errorMessage));
      },
      (r) {
        emit(CartSucceedState());
      },
    );
  }

  updateCart({required int id, required int quantity}) async {
    if (isClosed) return;

    var res = await updateItemCartUseCase.call(id: id, quantity: quantity);
    if (isClosed) return;

    res.fold(
      (l) {
        emit(CartFailureState(message: l.errorMessage));
      },
      (r) {
        emit(CartSucceedState());
      },
    );
  }

  checkOut() async {
    emit(CheckoutLoadingState());

    var res = await checkOutUseCase.call();
    if (isClosed) return;

    res.fold(
      (l) {
        emit(CartFailureState(message: l.errorMessage));
      },
      (r) {
        emit(CartSucceedState());
      },
    );
  }

  submitOrder(User user) async {
    if (isClosed) return;
    emit(PlaceOrderLoadingState());
    var res = await submitOrderUseCase.call(user);
    if (isClosed) return;

    res.fold(
      (l) {
        emit(CartFailureState(message: l.errorMessage));
      },
      (r) {
        emit(CartSucceedState());
      },
    );
  }

  reFillDataUser() {
    var user = SharedPref.getUserData() as AuthUSer;

    email.text = user.email ?? "";
    phone.text = user.phone ?? "";
    address.text = user.address ?? "";
    name.text = user.name ?? "";
  }
}
