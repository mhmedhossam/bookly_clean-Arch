import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/home/data/data_source/home_datasource.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeDatasource homeDatasource;
  bool? isConnect;
  HomeRepositoryImpl({required this.homeDatasource});

  @override
  Future<Either<Failure, ProductModel>> getAllProduct() async {
    return await isConnection<ProductModel>(homeDatasource.getAllProduct());
  }

  @override
  Future<Either<Failure, ProductModel>> getBestSellerProduct() async {
    return await isConnection(homeDatasource.getBestSellerProduct());
  }

  @override
  Future<Either<Failure, ProductModel>> getSearch(String product) async {
    return await isConnection(homeDatasource.getSearch(product));
  }

  @override
  Future<Either<Failure, HomeSliderModel>> getSlider() async {
    return await isConnection(homeDatasource.getSlider());
  }
}
