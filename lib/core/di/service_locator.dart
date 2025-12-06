import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource_impl.dart';
import 'package:bookia/features/auth/data/repo/auth_repository_Impl.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/forget_pass_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/setNpass_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/authtcubit.dart';
import 'package:bookia/features/cartlist/data/data_source/remote_data_source.dart';
import 'package:bookia/features/cartlist/data/data_source/remote_data_sourceImpl.dart';
import 'package:bookia/features/cartlist/data/repo/cart_repositoryImpl.dart';
import 'package:bookia/features/cartlist/domain/repo/cart_repository.dart';
import 'package:bookia/features/cartlist/domain/usecases/add_to_cart_use_case.dart';
import 'package:bookia/features/cartlist/domain/usecases/check_out_repo_use_case.dart';
import 'package:bookia/features/cartlist/domain/usecases/get_cart_list_use_case.dart';
import 'package:bookia/features/cartlist/domain/usecases/remove_from_cart.dart';
import 'package:bookia/features/cartlist/domain/usecases/submit_order_usecase.dart';
import 'package:bookia/features/cartlist/domain/usecases/update_item_cart_use_case.dart';
import 'package:bookia/features/home/data/data_source/home_datasource.dart';
import 'package:bookia/features/home/data/data_source/home_datasource_impl.dart';
import 'package:bookia/features/home/data/repo/Home_repository_Impl.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:bookia/features/home/domain/usecases/get_all_product_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_b_seller_p_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_search_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_slider_usecase.dart';
import 'package:bookia/features/profile/data/profile_data_source/profile_data_source.dart';
import 'package:bookia/features/profile/data/profile_data_source/profile_data_source_impl.dart';
import 'package:bookia/features/profile/data/repo/profile_repositoryImpl.dart';
import 'package:bookia/features/profile/domain/repo/profile_repository.dart';
import 'package:bookia/features/profile/domain/usecases/get_my_orders_usecase.dart';
import 'package:bookia/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:bookia/features/wishlist/data/repo/wish_repository_impl.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_data_source_impl.dart';
import 'package:bookia/features/wishlist/data/wishlist_data_source/wishlist_datasource.dart';
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
    // gi.registerSingleton(() => SharedPref.instance);
    // gi.registerSingleton(() => DioProvider.instance);
    gi.registerSingleton<SharedPref>(SharedPref().instance);
    gi.registerSingleton<DioProvider>(DioProvider().instance);

    //  register data source
    gi.registerLazySingleton<AuthDatasource>(() => AuthRemoteDatasourceImpl());
    gi.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());
    gi.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceimpl());
    gi.registerLazySingleton<WishlistDatasource>(
      () => WishlistDataSourceImpl(),
    );
    gi.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl());
    // register reposiatories

    gi.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(remoteDataSource: gi<RemoteDataSource>()),
    );
    gi.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: gi<AuthDatasource>()),
    );
    gi.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeDatasource: gi<HomeDatasource>()),
    );
    gi.registerLazySingleton<WishlistRepository>(
      () => WishRepositoryImpl(wishlistDatasource: gi<WishlistDatasource>()),
    );
    gi.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(profileDataSource: gi<ProfileDataSource>()),
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
    //profile

    gi.registerLazySingleton<GetMyOrdersUseCase>(
      () => GetMyOrdersUseCase(profileRepository: gi<ProfileRepository>()),
    );
    gi.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(profileRepository: gi<ProfileRepository>()),
    );
    //cart

    gi.registerLazySingleton<AddToCartUseCase>(
      () => AddToCartUseCase(cartRepository: gi<CartRepository>()),
    );
    gi.registerLazySingleton<CheckOutUseCase>(
      () => CheckOutUseCase(cartRepository: gi<CartRepository>()),
    );
    gi.registerLazySingleton<GetCartListUseCase>(
      () => GetCartListUseCase(cartRepository: gi<CartRepository>()),
    );
    gi.registerLazySingleton<RemoveFromCart>(
      () => RemoveFromCart(cartRepository: gi<CartRepository>()),
    );
    gi.registerLazySingleton<SubmitOrderUseCase>(
      () => SubmitOrderUseCase(cartRepository: gi<CartRepository>()),
    );
    gi.registerLazySingleton<UpdateItemCartUseCase>(
      () => UpdateItemCartUseCase(cartRepository: gi<CartRepository>()),
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
