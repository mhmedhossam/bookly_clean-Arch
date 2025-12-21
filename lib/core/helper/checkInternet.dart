import 'package:bookia/core/error/failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

Future<bool> checkConnection() async {
  final connectivity = await Connectivity().checkConnectivity();
  return connectivity != ConnectivityResult.none;
}

Future<bool> isConnection() async {
  bool isConnected = await checkConnection();
  return isConnected;
}
