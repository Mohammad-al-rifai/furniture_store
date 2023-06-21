import '../product_models/products_list_model.dart';

class RecommendedProModel {
  RecommendedProModel({
    this.message,
    this.status,
    this.recommendedProducts,
  });

  final String? message;
  final bool? status;
  final List<Product>? recommendedProducts;

  factory RecommendedProModel.fromJson(Map<String, dynamic> json) {
    return RecommendedProModel(
      message: json["message"],
      status: json["status"],
      recommendedProducts: json["data"] == null
          ? []
          : List<Product>.from(json["data"].map((x) => Product.fromJson(x as Map<String, dynamic>))),
    );
  }
}
