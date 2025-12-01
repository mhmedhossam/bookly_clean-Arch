import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/features/home/data/models/response/all_product_model/all_product_model/all_product_model.dart';
import 'package:bookia/features/home/data/models/response/slider_model/home_model.dart';
import 'package:bookia/features/home/data/repo/home_endpoints.dart';

class HomeRepo {
  //      headers: {'Authorization': 'Bearer $token'},

  static Future<HomeModel> getSlider() async {
    var res = await DioProvider.get(HomeEndpoints.slider);
    return HomeModel.fromjson(res);
  }

  static Future<ProductsModel> getSearch(String product) async {
    var res = await DioProvider.get(
      HomeEndpoints.searchProduct,
      queryParameters: {"name": product},
    );
    return ProductsModel.fromJson(res);
  }

  static Future<ProductsModel> getBestSellerPduct() async {
    var res = await DioProvider.get(HomeEndpoints.productBestSeller);

    return ProductsModel.fromJson(res);
  }

  static Future<ProductsModel> getAllProduct() async {
    var res = await DioProvider.get(HomeEndpoints.product);

    return ProductsModel.fromJson(res);
  }
}
