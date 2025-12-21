import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:bookia/features/wishlist/domain/usecases/wish_usecase.dart';
import 'package:dartz/dartz.dart';

class GetWishUseCase extends WishUseCase {
  GetWishUseCase({required super.wishlistRepository});

  Future<Either<Failure, WishListResponse>> call() {
    return wishlistRepository.getWishList();
  }
}
