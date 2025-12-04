import 'links.dart';
import 'meta.dart';
import 'order.dart';

class OrderHistoryResponse {
  List<Order>? orders;
  Meta? meta;
  Links? links;

  OrderHistoryResponse({this.orders, this.meta, this.links});

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponse(
        orders: (json['orders'] as List<dynamic>?)
            ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
        links: json['links'] == null
            ? null
            : Links.fromJson(json['links'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    'orders': orders?.map((e) => e.toJson()).toList(),
    'meta': meta?.toJson(),
    'links': links?.toJson(),
  };
}
