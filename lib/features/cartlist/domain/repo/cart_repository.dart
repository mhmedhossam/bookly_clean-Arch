import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> getCartList();
  Future<Either<Failure, CartModel>> addToCart(int id);
  Future<Either<Failure, CartModel>> removeFromCart(int id);
  Future<Either<Failure, CartModel>> updateItemCart({
    required int id,
    required int quantity,
  });
  Future<Either<Failure, CartModel>> checkOutRepo();
  Future<Either<Failure, CartModel>> submitOrder(User user);
}
