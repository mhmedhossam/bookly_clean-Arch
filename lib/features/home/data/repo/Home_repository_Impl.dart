import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/error/failure.dart';
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
    try {
      return Right(await homeDatasource.getAllProduct());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getBestSellerProduct() async {
    try {
      return Right(await homeDatasource.getBestSellerProduct());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getSearch(String product) async {
    try {
      return Right(await homeDatasource.getSearch(product));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeSliderModel>> getSlider() async {
    try {
      return Right(await homeDatasource.getSlider());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
