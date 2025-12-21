import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';

abstract class ProfileDataSource {
  Future<OrderHistoryResponse> getMyOrders();
  Future<ProfileResponse> upDateProfile(
    String name,
    String address,
    String phone,
  );
}
