import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/profile/data/profile_data_source/profile_data_source.dart';
import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:bookia/features/profile/domain/repo/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});
  @override
  Future<Either<Failure, OrderHistoryResponse>> getMyOrders() {
    return isConnection<OrderHistoryResponse>(profileDataSource.getMyOrders());
  }

  @override
  Future<Either<Failure, ProfileResponse>> upDateProfile(
    String name,
    String address,
    String phone,
  ) {
    return isConnection<ProfileResponse>(
      profileDataSource.upDateProfile(name, address, phone),
    );
  }
}
