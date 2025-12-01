import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/product.dart';
import 'package:bookia/features/wishlist/data/models/response/get_wish_list_response/get_wish_list_response.dart';
import 'package:bookia/features/wishlist/data/repo/wish_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  List<Product> wishList = [];

  WishlistCubit() : super(InitialState());

  getWishList() async {
    if (isClosed) return;
    emit(LoadingState());
    var res = await WishRepo.getWishList();
    if (isClosed) return;

    if (res.status != 200) {
      emit(FailureStates(message: res.message));
    } else {
      emit(SucceededState());

      wishList = res.data?.data ?? [];
    }
  }

  removeFromWishList(int id) async {
    if (isClosed) return;

    GetWishListResponse res = await WishRepo.removeFromWishList(id);
    if (isClosed) return;

    if (res.status != 200) {
      emit(FailureStates(message: res.message));
    } else {
      emit(SucceededState());

      wishList = res.data?.data ?? [];
    }
  }
}
