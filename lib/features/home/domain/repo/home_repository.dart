import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeSliderModel>> getSlider();
  Future<Either<Failure, ProductModel>> getSearch(String product);
  Future<Either<Failure, ProductModel>> getBestSellerProduct();
  Future<Either<Failure, ProductModel>> getAllProduct();
}
