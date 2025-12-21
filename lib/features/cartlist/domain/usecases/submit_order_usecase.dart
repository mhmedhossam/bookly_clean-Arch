import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/domain/usecases/cart_usecase.dart';
import 'package:dartz/dartz.dart';

class SubmitOrderUseCase extends CartUseCase {
  SubmitOrderUseCase({required super.cartRepository});

  Future<Either<Failure, CartModel>> call(User user) {
    return cartRepository.submitOrder(user);
  }
}
