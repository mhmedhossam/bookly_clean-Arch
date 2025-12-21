import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';

abstract class HomeDatasource {
  Future<HomeSliderModel> getSlider();
  Future<ProductModel> getSearch(String product);
  Future<ProductModel> getBestSellerProduct();
  Future<ProductModel> getAllProduct();
}
