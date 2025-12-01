import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/user.dart';
import 'package:bookia/features/profile/data/models/response/get_profile_response/get_profile_response.dart';
import 'package:bookia/features/profile/data/models/response/response_order_history/response_order_history.dart';
import 'package:bookia/features/profile/data/repo/profile_endpoints.dart';

class ProfileRepo {
  static getProfileData() async {
    var res = await DioProvider.get(
      ProfileEndpoints.getProfile,
      headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return GetProfileResponse.fromJson(res);
  }

  static getMyOrder() async {
    var res = await DioProvider.get(
      ProfileEndpoints.getOrderHistory,
      headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
    );

    return ResponseOrderHistory.fromJson(res);
  }

  static updateProfile({
    required String name,
    required String address,
    required String phone,
  }) async {
    try {
      var res = await DioProvider.post(
        ProfileEndpoints.updateProfile,
        data: {"name": name, "address": address, "phone": phone},

        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
      );
      var profileResponse = GetProfileResponse.fromJson(res);

      AuthUSer user = AuthUSer(
        address: profileResponse.data?.address,
        name: profileResponse.data?.name,
        phone: profileResponse.data?.phone,
        image: profileResponse.data?.image,
        email: profileResponse.data?.email,
      );
      SharedPref.setusercache(user);
      print(SharedPref.getUserData());
      return profileResponse;
    } catch (e) {
      throw (e.toString());
    }
  }
}
