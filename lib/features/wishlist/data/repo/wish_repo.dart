import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/models/response/get_wish_list_response/get_wish_list_response.dart';
import 'package:bookia/features/wishlist/data/repo/wish_endpoints.dart';

class WishRepo {
  static String? token = SharedPref.getToken();

  static Future<GetWishListResponse> getWishList() async {
    var res = await DioProvider.get(
      WishEndpoints.getWishList,
      headers: {'Authorization': 'Bearer $token'},
    );
    return GetWishListResponse.fromJson(res);
  }

  static Future<GetWishListResponse> addToWishList(int id) async {
    var res = await DioProvider.post(
      data: {"product_id": id},

      WishEndpoints.addToWishList,
      headers: {'Authorization': 'Bearer $token'},
    );
    return GetWishListResponse.fromJson(res);
  }

  static Future<GetWishListResponse> removeFromWishList(int id) async {
    var res = await DioProvider.post(
      data: {"product_id": id},

      WishEndpoints.removeFromWishList,
      headers: {'Authorization': 'Bearer $token'},
    );
    return GetWishListResponse.fromJson(res);
  }
}
