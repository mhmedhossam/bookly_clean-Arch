import 'package:bookia/features/home/domain/entities/all_products_model/product.dart';
import 'package:bookia/features/wishlist/domain/usecases/add_to_wish_usecase.dart';
import 'package:bookia/features/wishlist/domain/usecases/get_wish_usecase.dart';
import 'package:bookia/features/wishlist/domain/usecases/remove_from_wish_usecase.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  List<Product> wishList = [];
  GetWishUseCase getWishUseCase;
  RemoveFromWishUseCase removeFromWishUseCase;
  WishlistCubit({
    required this.getWishUseCase,
    required this.removeFromWishUseCase,
  }) : super(InitialState());

  getWishList() async {
    if (isClosed) return;
    emit(LoadingState());
    var res = await getWishUseCase.call();
    if (isClosed) return;

    res.fold(
      (l) {
        emit(FailureStates(message: l.errorMessage));
      },
      (r) {
        emit(SucceededState());
        wishList = r.data ?? [];
      },
    );
  }

  removeFromWishList(int id) async {
    if (isClosed) return;

    var res = await removeFromWishUseCase.call(id);
    if (isClosed) return;

    res.fold(
      (l) {
        emit(FailureStates(message: l.errorMessage));
      },
      (r) {
        emit(SucceededState());
        wishList = r.data ?? [];
      },
    );
  }
}
