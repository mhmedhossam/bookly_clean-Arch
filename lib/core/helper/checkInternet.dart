import 'package:bookia/core/services/api/failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

Future<bool> checkConnection() async {
  final connectivity = await Connectivity().checkConnectivity();
  return connectivity != ConnectivityResult.none;
}

Future<Either<Failure, T>> isConnection<T>(
  Future<Either<Failure, T>> source,
) async {
  bool isConnected = await checkConnection();
  return isConnected ? source : Left(NetworkFailure("no Internet connection"));
}
