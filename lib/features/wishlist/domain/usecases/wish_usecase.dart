import 'package:bookia/features/wishlist/domain/repo/wishlist_repository.dart';

abstract class WishUseCase {
  WishlistRepository wishlistRepository;

  WishUseCase({required this.wishlistRepository});
}
