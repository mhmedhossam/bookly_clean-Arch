import 'links.dart';
import 'meta.dart';
import 'product.dart';

class ProductModel {
  List<Product>? products;
  Meta? meta;
  Links? links;

  ProductModel({this.products, this.meta, this.links});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList(),
    'meta': meta?.toJson(),
    'links': links?.toJson(),
  };
}
