import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/usecases/cart_usecase.dart';
import 'package:dartz/dartz.dart';

class RemoveFromCart extends CartUseCase {
  RemoveFromCart({required super.cartRepository});

  Future<Either<Failure, CartModel>> call(int id) {
    return cartRepository.removeFromCart(id);
  }
}
