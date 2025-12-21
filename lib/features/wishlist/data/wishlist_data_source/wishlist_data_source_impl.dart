import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/repo/wish_endpoints.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_datasource.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:dio/dio.dart';

class WishlistDataSourceImpl extends WishlistDatasource {
  @override
  String? token = SharedPref.getToken();
  @override
  Future<WishListResponse> addToWishList(int id) async {
    try {
      var res = await DioProvider.post(
        data: {"product_id": id},

        WishEndpoints.addToWishList,
        headers: {'Authorization': 'Bearer $token'},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return WishListResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    }
  }

  @override
  Future<WishListResponse> getWishList() async {
    try {
      var res = await DioProvider.get(
        WishEndpoints.getWishList,
        headers: {'Authorization': 'Bearer $token'},
      );

      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return WishListResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    }
  }

  @override
  Future<WishListResponse> removeFromWishList(int id) async {
    try {
      var res = await DioProvider.post(
        data: {"product_id": id},

        WishEndpoints.removeFromWishList,
        headers: {'Authorization': 'Bearer $token'},
      );

      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return WishListResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    }
  }
}
