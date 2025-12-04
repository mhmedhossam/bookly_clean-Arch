import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_datasource.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:bookia/features/wishlist/domain/repo/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class WishRepositoryImpl extends WishlistRepository {
  WishlistDatasource wishlistDatasource;
  WishRepositoryImpl({required this.wishlistDatasource});
  @override
  Future<Either<Failure, WishListResponse>> addToWishList(int id) {
    return isConnection<WishListResponse>(wishlistDatasource.addToWishList(id));
  }

  @override
  Future<Either<Failure, WishListResponse>> getWishList() {
    return isConnection<WishListResponse>(wishlistDatasource.getWishList());
  }

  @override
  Future<Either<Failure, WishListResponse>> removeFromWishList(int id) {
    return isConnection<WishListResponse>(
      wishlistDatasource.removeFromWishList(id),
    );
  }
}
