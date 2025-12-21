import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/features/home/data/data_source/home_datasource.dart';
import 'package:bookia/features/home/data/repo/home_endpoints.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';
import 'package:dio/dio.dart';

class HomeDatasourceImpl extends HomeDatasource {
  @override
  Future<HomeSliderModel> getSlider() async {
    try {
      var res = await DioProvider.get(HomeEndpoints.slider);
      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return HomeSliderModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      print("hwswsw");
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<ProductModel> getBestSellerProduct() async {
    try {
      var res = await DioProvider.get(HomeEndpoints.productBestSeller);

      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return ProductModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<ProductModel> getSearch(String product) async {
    try {
      var res = await DioProvider.get(
        HomeEndpoints.searchProduct,
        queryParameters: {"name": product},
      );

      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return ProductModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<ProductModel> getAllProduct() async {
    try {
      var res = await DioProvider.get(HomeEndpoints.product);

      var baseModel = BaseResponse.fromJson(res.data);
      if (baseModel.data is Map<String, dynamic>) {
        return ProductModel.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }
}
