import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/cartlist/data/data_source/remote_data_source.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/domain/repo/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl extends CartRepository {
  RemoteDataSource remoteDataSource;
  CartRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, CartModel>> addToCart(int id) {
    return isConnection(remoteDataSource.addToCart(id));
  }

  @override
  Future<Either<Failure, CartModel>> checkOutRepo() {
    return isConnection(remoteDataSource.checkOutRepo());
  }

  @override
  Future<Either<Failure, CartModel>> getCartList() {
    return isConnection(remoteDataSource.getCartList());
  }

  @override
  Future<Either<Failure, CartModel>> removeFromCart(int id) {
    return isConnection(remoteDataSource.removeFromCart(id));
  }

  @override
  Future<Either<Failure, CartModel>> submitOrder(User user) {
    return isConnection(remoteDataSource.submitOrder(user));
  }

  @override
  Future<Either<Failure, CartModel>> updateItemCart({
    required int id,
    required int quantity,
  }) {
    return isConnection(
      remoteDataSource.updateItemCart(id: id, quantity: quantity),
    );
  }
}
