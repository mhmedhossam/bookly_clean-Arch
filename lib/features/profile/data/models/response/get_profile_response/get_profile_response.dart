import 'package:bookia/features/profile/data/models/response/get_profile_response/data.dart';

class GetProfileResponse {
  Data? data;
  String? message;
  dynamic error;
  int? status;

  GetProfileResponse({this.data, this.error, this.message, this.status});

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      message: json["message"],
      error: json["error"],
      status: json["status"],
      data: json["data"] is List<dynamic> ? null : Data.fromJson(json["data"]),
    );
  }
}
