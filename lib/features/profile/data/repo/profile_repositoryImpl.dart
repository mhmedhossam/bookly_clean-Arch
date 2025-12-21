import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/profile/data/profile_data_source/profile_data_source.dart';
import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:bookia/features/profile/domain/repo/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});
  @override
  Future<Either<Failure, OrderHistoryResponse>> getMyOrders() async {
    try {
      return Right(await profileDataSource.getMyOrders());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProfileResponse>> upDateProfile(
    String name,
    String address,
    String phone,
  ) async {
    try {
      return Right(await profileDataSource.upDateProfile(name, address, phone));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
