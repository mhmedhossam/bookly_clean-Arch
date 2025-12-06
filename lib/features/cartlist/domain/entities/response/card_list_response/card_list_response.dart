// import 'data.dart';

// class CardListResponse {
//   Data? data;
//   String? message;
//   List<dynamic>? error;
//   int? status;

//   CardListResponse({this.data, this.message, this.error, this.status});

//   factory CardListResponse.fromJson(Map<String, dynamic> json) {
//     return CardListResponse(
//       data: json['data'] == null || json['data'] is List<dynamic>
//           ? null
//           : Data.fromJson(json['data'] as Map<String, dynamic>),
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
