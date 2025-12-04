import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/profile/domain/entities/response/response_order_history/order_history_response.dart';
import 'package:bookia/features/profile/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMyOrdersUseCase extends UseCase {
  GetMyOrdersUseCase({required super.profileRepository});
  Future<Either<Failure, OrderHistoryResponse>> call() {
    return profileRepository.getMyOrders();
  }
}
