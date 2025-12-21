import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_datasource.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:bookia/features/wishlist/domain/repo/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class WishRepositoryImpl extends WishlistRepository {
  WishlistDatasource wishlistDatasource;
  WishRepositoryImpl({required this.wishlistDatasource});
  @override
  Future<Either<Failure, WishListResponse>> addToWishList(int id) async {
    try {
      return Right(await wishlistDatasource.addToWishList(id));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, WishListResponse>> getWishList() async {
    try {
      return Right(await wishlistDatasource.getWishList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, WishListResponse>> removeFromWishList(int id) async {
    try {
      return Right(await wishlistDatasource.removeFromWishList(id));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
