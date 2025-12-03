// import 'data.dart';

// class ForgetPassword {
//   Data? data;
//   String? message;
//   List<dynamic>? error;
//   int? status;

//   ForgetPassword({this.data, this.message, this.error, this.status});

//   factory ForgetPassword.fromJson(Map<String, dynamic> json) {
//     return ForgetPassword(
//       data: json["data"] is Map<String, dynamic>
//           ? Data.fromJson(json["data"] as Map<String, dynamic>)
//           : null,
//       message: json['message'] as String?,
//       error: json['error'] as List<dynamic>?,
//       status: json['status'] as int?,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'data': data?.toJson(),
//     'message': message,
//     'error': error,
//     'status': status,
//   };
// }
