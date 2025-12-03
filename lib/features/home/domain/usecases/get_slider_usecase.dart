import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/home/domain/entities/slider_model/home_slider_model.dart';
import 'package:bookia/features/home/domain/repo/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetSliderUseCase {
  HomeRepository homeRepository;

  GetSliderUseCase({required this.homeRepository});

  Future<Either<Failure, HomeSliderModel>> call() async {
    return await homeRepository.getSlider();
  }
}
