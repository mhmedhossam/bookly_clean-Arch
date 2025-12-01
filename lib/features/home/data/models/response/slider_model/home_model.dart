import 'package:bookia/features/home/data/models/response/slider_model/data.dart';

class HomeModel {
  Data? data;
  String? message;
  dynamic error;
  int? status;

  HomeModel({this.data, this.error, this.message, this.status});

  factory HomeModel.fromjson(json) {
    return HomeModel(
      data: Data.fromjson(json?["data"] as Map<String, dynamic>?),
      error: json?["error"] as dynamic,

      message: json?["message"] as String?,
      status: json?["status"] as int?,
    );
  }
}
