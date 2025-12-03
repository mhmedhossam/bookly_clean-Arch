import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/home/data/data_source/home_datasource.dart';
import 'package:bookia/features/home/data/repo/home_endpoints.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';
import 'package:dartz/dartz.dart';

class HomeDatasourceImpl extends HomeDatasource {
  @override
  Future<Either<Failure, HomeSliderModel>> getSlider() async {
    var res = await DioProvider.get<HomeSliderModel>(
      HomeEndpoints.slider,
      fromJson: (json) => HomeSliderModel.fromJson(json),
    );

    return res;
  }

  @override
  Future<Either<Failure, ProductModel>> getBestSellerProduct() async {
    var res = await DioProvider.get<ProductModel>(
      HomeEndpoints.productBestSeller,
      fromJson: (json) => ProductModel.fromJson(json),
    );

    return res;
  }

  @override
  Future<Either<Failure, ProductModel>> getSearch(String product) async {
    var res = await DioProvider.get<ProductModel>(
      HomeEndpoints.searchProduct,
      queryParameters: {"name": product},
      fromJson: (json) => ProductModel.fromJson(json),
    );

    return res;
  }

  @override
  Future<Either<Failure, ProductModel>> getAllProduct() async {
    var res = await DioProvider.get<ProductModel>(
      HomeEndpoints.product,
      fromJson: (json) => ProductModel.fromJson(json),
    );

    return res;
  }
}
