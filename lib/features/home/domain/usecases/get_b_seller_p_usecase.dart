import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetBSellerPUseCase {
  HomeRepository homeRepository;
  GetBSellerPUseCase({required this.homeRepository});
  Future<Either<Failure, ProductModel>> call() {
    return homeRepository.getBestSellerProduct();
  }
}
