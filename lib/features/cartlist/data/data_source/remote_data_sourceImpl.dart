import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cartlist/data/data_source/remote_data_source.dart';
import 'package:bookia/features/cartlist/data/data_source/cardlist_endpoint.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/data.dart';
import 'package:bookia/features/cartlist/domain/entities/response/card_list_response/user.dart';
import 'package:dartz/dartz.dart';

class RemoteDataSourceimpl extends RemoteDataSource {
  @override
  Future<Either<Failure, CartModel>> addToCart(int id) async {
    try {
      var res = await DioProvider.post<CartModel>(
        CartListEndpoint.addToCard,
        data: {"product_id": id},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        json: (json) {
          return CartModel.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> checkOutRepo() async {
    try {
      var res = await DioProvider.get<CartModel>(
        CartListEndpoint.checkOut,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        fromJson: (json) {
          return CartModel.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> getCartList() async {
    try {
      var res = await DioProvider.get<CartModel>(
        CartListEndpoint.getCardList,
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        fromJson: (json) {
          return CartModel.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> removeFromCart(int id) async {
    try {
      var res = await DioProvider.post<CartModel>(
        CartListEndpoint.removeFromCard,
        data: {"cart_item_id": id},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        json: (json) {
          return CartModel.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> submitOrder(User user) async {
    try {
      var res = await DioProvider.post<CartModel>(
        CartListEndpoint.placeOrder,
        data: user.toJson(),
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
        json: (json) {
          return CartModel.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> updateItemCart({
    required int id,
    required int quantity,
  }) async {
    try {
      var res = await DioProvider.post<CartModel>(
        CartListEndpoint.updateToCard,
        data: {"cart_item_id": id, "quantity": quantity},
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},

        json: (json) {
          return CartModel.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
