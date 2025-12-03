import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/repo/auth_endpoints.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteDatasourceImpl extends AuthDatasource {
  @override
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequesr authDataRequesr,
  ) async {
    try {
      var data = await DioProvider.post(
        AuthEndpoints.register,
        data: authDataRequesr.toJson(),
      );
      return Right(AuthResponse.fromjson(data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login(
    AuthDataRequesr authDataRequesr,
  ) async {
    try {
      var data = await DioProvider.post(
        AuthEndpoints.login,
        data: authDataRequesr.toJson(),
      );

      var succeedData = AuthResponse.fromjson(data);
      SharedPref.setToken(succeedData.data?.token);
      SharedPref.setusercache(succeedData.data?.user);
      return Right(succeedData);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
