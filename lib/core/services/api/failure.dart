abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure(super.errorMessage);
}
