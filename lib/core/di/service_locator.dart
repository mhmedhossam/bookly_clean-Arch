import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource_impl.dart';
import 'package:bookia/features/auth/data/repo/auth_repository_Impl.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/%D9%90auth_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/forget_pass_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/setNpass_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/authtcubit.dart';
import 'package:bookia/features/home/data/data_source/home_datasource.dart';
import 'package:bookia/features/home/data/data_source/home_datasource_impl.dart';
import 'package:bookia/features/home/data/repo/Home_repository_Impl.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:bookia/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_b_seller_p_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_search_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_slider_usecase.dart';
import 'package:bookia/features/wishlist/data/repo/wish_repository_impl.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_data_source_impl.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_datasource.dart';
import 'package:bookia/features/wishlist/domain/entities/response/wish_list_response.dart';
import 'package:bookia/features/wishlist/domain/repo/wishlist_repository.dart';
import 'package:bookia/features/wishlist/domain/usecases/add_to_wish_usecase.dart';
import 'package:bookia/features/wishlist/domain/usecases/get_wish_usecase.dart';
import 'package:bookia/features/wishlist/domain/usecases/remove_from_wish_usecase.dart';
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
    gi.registerLazySingleton<WishlistDatasource>(
      () => WishlistDataSourceImpl(),
    );
    // register reposiatories

    gi.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: gi<AuthDatasource>()),
    );
    gi.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeDatasource: gi<HomeDatasource>()),
    );
    gi.registerLazySingleton<WishlistRepository>(
      () => WishRepositoryImpl(wishlistDatasource: gi<WishlistDatasource>()),
    );
    //register usecases
    //Auth
    gi.registerLazySingleton<ForgetPassUseCase>(
      () => ForgetPassUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<OtpVerifyUseCase>(
      () => OtpVerifyUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<SetNPassUseCase>(
      () => SetNPassUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: gi<AuthRepository>()),
    );
    gi.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepository: gi<AuthRepository>()),
    );
    //  ------------------------------

    //home
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
    //  ------------------------------

    //wish

    gi.registerLazySingleton<AddToWishUseCase>(
      () => AddToWishUseCase(wishlistRepository: gi<WishlistRepository>()),
    );
    gi.registerLazySingleton<RemoveFromWishUseCase>(
      () => RemoveFromWishUseCase(wishlistRepository: gi<WishlistRepository>()),
    );
    gi.registerLazySingleton<GetWishUseCase>(
      () => GetWishUseCase(wishlistRepository: gi<WishlistRepository>()),
    );

    // //register cubits

    gi.registerFactory<Authtcubit>(
      () => Authtcubit(
        forgetPassUseCase: ServiceLocator.gi<ForgetPassUseCase>(),
        otpVerifyUseCase: ServiceLocator.gi<OtpVerifyUseCase>(),
        setNPassUseCase: ServiceLocator.gi<SetNPassUseCase>(),
        loginUseCase: ServiceLocator.gi<LoginUseCase>(),
        registerUseCase: ServiceLocator.gi<RegisterUseCase>(),
      ),
    );
  }
}
