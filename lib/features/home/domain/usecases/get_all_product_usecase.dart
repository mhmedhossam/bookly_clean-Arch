import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/home/domain/entities/all_products_model/product_model.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllProductUseCase {
  HomeRepository homeRepository;

  GetAllProductUseCase({required this.homeRepository});

  Future<Either<Failure, ProductModel>> call() async {
    return await homeRepository.getAllProduct();
  }
}
