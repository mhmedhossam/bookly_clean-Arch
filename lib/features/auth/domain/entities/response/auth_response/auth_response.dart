// import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';

// class AuthResponse {
//   Data? data;
//   String? message;
//   dynamic error;
//   int? status;

//   AuthResponse({this.data, this.error, this.message, this.status});

//   factory AuthResponse.fromjson(json) {
//     return AuthResponse(
//       data: json?["data"] is Map<String, dynamic>
//           ? Data.fromjson(json?["data"] as Map<String, dynamic>)
//           : null,
//       error: json?["error"] is Map<String, dynamic>
//           ? json["error"] as Map<String, dynamic>?
//           : json["error"] as List<dynamic>?,
//       message: json?["message"] as String?,
//       status: json?["status"] as int?,
//     );
//   }
// }
