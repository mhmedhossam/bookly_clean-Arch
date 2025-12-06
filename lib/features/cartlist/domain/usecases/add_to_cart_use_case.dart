import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/usecases/cart_usecase.dart';
import 'package:dartz/dartz.dart';

class AddToCartUseCase extends CartUseCase {
  AddToCartUseCase({required super.cartRepository});

  Future<Either<Failure, CartModel>> call(int id) {
    return cartRepository.addToCart(id);
  }
}
