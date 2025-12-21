import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<Failure, WishListResponse>> getWishList();
  Future<Either<Failure, WishListResponse>> addToWishList(int id);

  Future<Either<Failure, WishListResponse>> removeFromWishList(int id);
}
