import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource_impl.dart';
import 'package:bookia/features/auth/data/repo/auth_repository_Impl.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final gi = GetIt.instance;

  static setupServiceLocator() async {
    //register services

    await DioProvider().init();
    await SharedPref().init();
    // gi.registerSingleton<DioProvider>(dio);
    // gi.registerSingleton<SharedPref>(sharedPref);

    //  register data source
    gi.registerLazySingleton<AuthDatasource>(() => AuthRemoteDatasourceImpl());

    // register reposiatories

    gi.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: gi<AuthDatasource>()),
    );

    //register usecases

    gi.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepository: gi<AuthRepository>()),
    );

    // //register cubits

    // gi.registerLazySingleton<Authtcubit>(
    //   () => Authtcubit(
    //     loginUseCase: gi<LoginUseCase>(),
    //     registerUseCase: gi<RegisterUseCase>(),
    //   ),
    // );
  }
}
