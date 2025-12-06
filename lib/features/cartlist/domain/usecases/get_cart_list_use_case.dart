import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/usecases/cart_usecase.dart';
import 'package:dartz/dartz.dart';

class GetCartListUseCase extends CartUseCase {
  GetCartListUseCase({required super.cartRepository});

  Future<Either<Failure, CartModel>> call() {
    return cartRepository.getCartList();
  }
}
