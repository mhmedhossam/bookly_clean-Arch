import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/usecases/cart_usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateItemCartUseCase extends CartUseCase {
  UpdateItemCartUseCase({required super.cartRepository});

  Future<Either<Failure, CartModel>> call({
    required int id,
    required int quantity,
  }) {
    return cartRepository.updateItemCart(id: id, quantity: quantity);
  }
}
