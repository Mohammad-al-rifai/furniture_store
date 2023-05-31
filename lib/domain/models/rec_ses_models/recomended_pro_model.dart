import '../product_models/products_list_model.dart';

class RecommendedProModel {
  RecommendedProModel({
    this.status,
    this.recommendedProducts,
  });

  final bool? status;
  final List<Product>? recommendedProducts;

  factory RecommendedProModel.fromJson(Map<String, dynamic> json) {
    return RecommendedProModel(
      status: json["status"],
      recommendedProducts: json["recommendedProducts"] == null
          ? []
          : List<Product>.from(
              json["recommendedProducts"]!.map((x) => Product.fromJson(x))),
    );
  }
}
