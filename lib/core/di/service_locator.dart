import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource_impl.dart';
import 'package:bookia/features/auth/data/repo/auth_repository_Impl.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/home/data/data_source/home_datasource.dart';
import 'package:bookia/features/home/data/data_source/home_datasource_impl.dart';
import 'package:bookia/features/home/data/repo/Home_repository_Impl.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:bookia/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_b_seller_p_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_search_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_slider_usecase.dart';
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
    gi.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());
    // register reposiatories

    gi.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: gi<AuthDatasource>()),
    );
    gi.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeDatasource: gi<HomeDatasource>()),
    );
    //register usecases

    gi.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<GetAllProductUseCase>(
      () => GetAllProductUseCase(homeRepository: gi<HomeRepository>()),
    );
    gi.registerLazySingleton<GetBSellerPUseCase>(
      () => GetBSellerPUseCase(homeRepository: gi<HomeRepository>()),
    );
    gi.registerLazySingleton<GetSearchUseCase>(
      () => GetSearchUseCase(homeRepository: gi<HomeRepository>()),
    );
    gi.registerLazySingleton<GetSliderUseCase>(
      () => GetSliderUseCase(homeRepository: gi<HomeRepository>()),
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
