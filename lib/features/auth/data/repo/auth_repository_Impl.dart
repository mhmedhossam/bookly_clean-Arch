import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthDatasource authDatasource;
  late bool isConnected;
  AuthRepositoryImpl({required this.authDatasource});
  Future<bool> checkConnection() async {
    return await Connectivity().checkConnectivity() != ConnectivityResult.none;
  }

  @override
  Future<Either<Failure, AuthResponse>> login(
    AuthDataRequesr authDataRequesr,
  ) async {
    isConnected = await checkConnection();
    if (isConnected) {
      return authDatasource.login(authDataRequesr);
    } else {
      return Left(NetworkFailure("no Internet connection"));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequesr authDataRequesr,
  ) async {
    isConnected = await checkConnection();
    if (isConnected) {
      return authDatasource.login(authDataRequesr);
    } else {
      return Left(NetworkFailure("no Internet connection"));
    }
  }
}
