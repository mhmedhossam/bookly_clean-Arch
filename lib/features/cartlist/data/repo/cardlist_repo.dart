import 'dart:developer';

import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cartlist/data/models/response/card_list_response/card_list_response.dart';
import 'package:bookia/features/cartlist/data/models/response/card_list_response/user.dart';
import 'package:bookia/features/cartlist/data/repo/cardlist_endpoint.dart';

class CardlistRepo {
  static Future<CardListResponse> getCartList() async {
    var res = await DioProvider.get(
      CardlistEndpoint.getCardList,
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return CardListResponse.fromJson(res);
  }

  static Future<CardListResponse> addToCart(int id) async {
    var res = await DioProvider.post(
      CardlistEndpoint.addToCard,
      data: {"product_id": id},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return CardListResponse.fromJson(res);
  }

  static Future<CardListResponse> removeFromCart(int id) async {
    var res = await DioProvider.post(
      CardlistEndpoint.removeFromCard,
      data: {"cart_item_id": id},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return CardListResponse.fromJson(res);
  }

  static Future<CardListResponse> updateItemCart({
    required int id,
    required int quantity,
  }) async {
    var res = await DioProvider.post(
      CardlistEndpoint.updateToCard,

      data: {"cart_item_id": id, "quantity": quantity},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return CardListResponse.fromJson(res);
  }

  static Future<CardListResponse> checkOutRepo() async {
    var res = await DioProvider.get(
      CardlistEndpoint.checkOut,
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return CardListResponse.fromJson(res);
  }

  static Future<CardListResponse> submitOrder(User user) async {
    try {
      var res = await DioProvider.post(
        CardlistEndpoint.placeOrder,
        data: user.toJson(),
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      return CardListResponse.fromJson(res);
    } on Exception catch (e) {
      log(e.toString());
      throw (e.toString());
      // TODO
    }
  }
}
