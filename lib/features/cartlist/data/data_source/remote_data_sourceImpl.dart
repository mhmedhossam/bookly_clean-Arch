import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cartlist/data/data_source/remote_data_source.dart';
import 'package:bookia/features/cartlist/data/data_source/cardlist_endpoint.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:dio/dio.dart';

class RemoteDataSourceimpl extends RemoteDataSource {
  @override
  Future<CartModel> addToCart(int id) async {
    try {
      var res = await DioProvider.post(
        CartListEndpoint.addToCard,
        data: {"product_id": id},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return CartModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<CartModel> checkOutRepo() async {
    try {
      var res = await DioProvider.get(
        CartListEndpoint.checkOut,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return CartModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<CartModel> getCartList() async {
    try {
      var res = await DioProvider.get(
        CartListEndpoint.getCardList,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return CartModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<CartModel> removeFromCart(int id) async {
    try {
      var res = await DioProvider.post(
        CartListEndpoint.removeFromCard,
        data: {"cart_item_id": id},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return CartModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<CartModel> submitOrder(User user) async {
    try {
      var res = await DioProvider.post(
        CartListEndpoint.placeOrder,
        data: user.toJson(),
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return CartModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<CartModel> updateItemCart({
    required int id,
    required int quantity,
  }) async {
    try {
      var res = await DioProvider.post(
        CartListEndpoint.updateToCard,
        data: {"cart_item_id": id, "quantity": quantity},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return CartModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }
}
