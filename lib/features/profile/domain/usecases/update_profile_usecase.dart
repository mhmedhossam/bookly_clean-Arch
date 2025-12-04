import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/profile/domain/entities/response/get_profile_response/profile_response.dart';
import 'package:bookia/features/profile/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase extends UseCase {
  UpdateProfileUseCase({required super.profileRepository});

  Future<Either<Failure, ProfileResponse>> call(
    String name,
    String address,
    String phone,
  ) {
    return profileRepository.upDateProfile(name, address, phone);
  }
}
