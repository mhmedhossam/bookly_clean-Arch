import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/cartlist/data/data_source/remote_data_source.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/domain/repo/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl extends CartRepository {
  RemoteDataSource remoteDataSource;
  CartRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, CartModel>> addToCart(int id) async {
    try {
      return Right(await remoteDataSource.addToCart(id));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> checkOutRepo() async {
    try {
      return Right(await remoteDataSource.checkOutRepo());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> getCartList() async {
    try {
      return Right(await remoteDataSource.getCartList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> removeFromCart(int id) async {
    try {
      return Right(await remoteDataSource.removeFromCart(id));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> submitOrder(User user) async {
    try {
      return Right(await remoteDataSource.submitOrder(user));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CartModel>> updateItemCart({
    required int id,
    required int quantity,
  }) async {
    try {
      return Right(
        await remoteDataSource.updateItemCart(id: id, quantity: quantity),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
