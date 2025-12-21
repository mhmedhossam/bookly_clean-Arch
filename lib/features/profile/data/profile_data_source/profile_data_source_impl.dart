import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:bookia/features/profile/data/profile_data_source/profile_data_source.dart';
import 'package:bookia/features/profile/data/repo/profile_endpoints.dart';
import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:dio/dio.dart';

class ProfileDataSourceImpl extends ProfileDataSource {
  @override
  Future<OrderHistoryResponse> getMyOrders() async {
    try {
      var res = await DioProvider.get(
        ProfileEndpoints.getOrderHistory,
        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is List<dynamic>) {
        return OrderHistoryResponse.fromJson(
          {"orders": []},
        ); // because when orders empty the api return list , not empty return map
      }

      return OrderHistoryResponse.fromJson(baseModel.data);
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<ProfileResponse> upDateProfile(
    String name,
    String address,
    String phone,
  ) async {
    try {
      var res = await DioProvider.post(
        ProfileEndpoints.updateProfile,
        data: {"name": name, "address": address, "phone": phone},

        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var baseModel = BaseResponse.fromJson(res.data);

      if (baseModel.data is Map<String, dynamic>) {
        var profileResponse = ProfileResponse.fromJson(baseModel.data);
        AuthUSer user = AuthUSer(
          address: profileResponse.address,
          name: profileResponse.name,
          phone: profileResponse.phone,
          image: profileResponse.image,
          email: profileResponse.email,
        );
        SharedPref.setUserCache(user);
        return profileResponse;
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
