import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';
import 'package:bookia/features/profile/data/profile_data_source/profile_data_source.dart';
import 'package:bookia/features/profile/data/repo/profile_endpoints.dart';
import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:dartz/dartz.dart';

class ProfileDataSourceImpl extends ProfileDataSource {
  @override
  Future<Either<Failure, OrderHistoryResponse>> getMyOrders() async {
    try {
      var res = await DioProvider.get<OrderHistoryResponse>(
        ProfileEndpoints.getOrderHistory,
        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
        fromJson: (json) {
          if (json is List<dynamic>) {
            print(SharedPref.getToken());
            return OrderHistoryResponse.fromJson(
              {"orders": []},
            ); // because when orders empty the api return list , not empty return map
          }
          return OrderHistoryResponse.fromJson(json);
        },
      );
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileResponse>> upDateProfile(
    String name,
    String address,
    String phone,
  ) async {
    try {
      var res = await DioProvider.post<ProfileResponse>(
        ProfileEndpoints.updateProfile,
        data: {"name": name, "address": address, "phone": phone},

        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
        json: (json) => ProfileResponse.fromJson(json),
      );

      ProfileResponse profileResponse = res.getRight();
      AuthUSer user = AuthUSer(
        address: profileResponse.address,
        name: profileResponse.name,
        phone: profileResponse.phone,
        image: profileResponse.image,
        email: profileResponse.email,
      );
      SharedPref.setUserCache(user);
      return res;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
