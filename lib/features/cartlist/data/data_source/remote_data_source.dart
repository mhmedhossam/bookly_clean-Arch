import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';

abstract class RemoteDataSource {
  Future<CartModel> getCartList();
  Future<CartModel> addToCart(int id);
  Future<CartModel> removeFromCart(int id);
  Future<CartModel> updateItemCart({required int id, required int quantity});
  Future<CartModel> checkOutRepo();
  Future<CartModel> submitOrder(User user);
}
