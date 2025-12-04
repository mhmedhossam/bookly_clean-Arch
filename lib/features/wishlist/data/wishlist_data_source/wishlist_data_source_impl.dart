import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/repo/wish_endpoints.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_datasource.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:dartz/dartz.dart';

class WishlistDataSourceImpl extends WishlistDatasource {
  @override
  String? token = SharedPref.getToken();
  @override
  Future<Either<Failure, WishListResponse>> addToWishList(int id) async {
    try {
      var res = await DioProvider.post<WishListResponse>(
        data: {"product_id": id},

        WishEndpoints.addToWishList,
        headers: {'Authorization': 'Bearer $token'},
        json: (json) {
          return WishListResponse.fromJson(json);
        },
      );

      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WishListResponse>> getWishList() async {
    try {
      var res = await DioProvider.get<WishListResponse>(
        WishEndpoints.getWishList,
        headers: {'Authorization': 'Bearer $token'},
        fromJson: (json) {
          return WishListResponse.fromJson(json);
        },
      );

      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WishListResponse>> removeFromWishList(int id) async {
    try {
      var res = await DioProvider.post<WishListResponse>(
        data: {"product_id": id},

        WishEndpoints.removeFromWishList,
        headers: {'Authorization': 'Bearer $token'},
        json: (json) {
          return WishListResponse.fromJson(json);
        },
      );

      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
