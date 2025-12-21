import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';

abstract class WishlistDatasource {
  Future<WishListResponse> getWishList();
  Future<WishListResponse> addToWishList(int id);

  Future<WishListResponse> removeFromWishList(int id);
}
