import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, OrderHistoryResponse>> getMyOrders();
  Future<Either<Failure, ProfileResponse>> upDateProfile(
    String name,
    String address,
    String phone,
  );
}
