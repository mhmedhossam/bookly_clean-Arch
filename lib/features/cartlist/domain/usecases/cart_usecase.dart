import 'package:bookia/features/cartlist/domain/repo/cart_repository.dart';

abstract class CartUseCase {
  CartRepository cartRepository;

  CartUseCase({required this.cartRepository});
}
