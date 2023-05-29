class ProductsListModel {
  ProductsListModel({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final ProductsListData? data;

  ProductsListModel copyWith({
    String? message,
    bool? status,
    ProductsListData? data,
  }) {
    return ProductsListModel(
      message: message ?? this.message,
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  factory ProductsListModel.fromJson(Map<String, dynamic> json) {
    return ProductsListModel(
      message: json["message"],
      status: json["status"],
      data:
          json["data"] == null ? null : ProductsListData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$message, $status, $data, ";
  }
}

class ProductsListData {
  ProductsListData({
    required this.products,
  });

  final List<Product> products;

  ProductsListData copyWith({
    List<Product>? products,
  }) {
    return ProductsListData(
      products: products ?? this.products,
    );
  }

  factory ProductsListData.fromJson(Map<String, dynamic> json) {
    return ProductsListData(
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "products": products.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$products, ";
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.mainCategorie,
    required this.productClass,
    required this.guarantee,
    required this.manufacturingMaterial,
    required this.mainImage,
  });

  final String? id;
  final String? name;
  final String? mainCategorie;
  final List<ProductClass> productClass;
  final int? guarantee;
  final String? manufacturingMaterial;
  final String? mainImage;

  Product copyWith({
    String? id,
    String? name,
    String? mainCategorie,
    List<ProductClass>? productClass,
    int? guarantee,
    String? manufacturingMaterial,
    String? mainImage,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      mainCategorie: mainCategorie ?? this.mainCategorie,
      productClass: productClass ?? this.productClass,
      guarantee: guarantee ?? this.guarantee,
      manufacturingMaterial:
          manufacturingMaterial ?? this.manufacturingMaterial,
      mainImage: mainImage ?? this.mainImage,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      mainCategorie: json["mainCategorie"],
      productClass: json["Class"] == null
          ? []
          : List<ProductClass>.from(
              json["Class"]!.map((x) => ProductClass.fromJson(x))),
      guarantee: json["Guarantee"],
      manufacturingMaterial: json["manufacturingMaterial"],
      mainImage: json["mainImage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mainCategorie": mainCategorie,
        "Class": productClass.map((x) => x.toJson()).toList(),
        "Guarantee": guarantee,
        "manufacturingMaterial": manufacturingMaterial,
        "mainImage": mainImage,
      };

  @override
  String toString() {
    return "$id, $name, $mainCategorie, $productClass, $guarantee, $manufacturingMaterial, $mainImage, ";
  }
}

class ProductClass {
  ProductClass({
    required this.size,
    required this.length,
    required this.width,
    required this.price,
    required this.sallableInPoints,
    required this.group,
    required this.id,
    required this.priceAfterDiscount,
  });

  final String? size;
  final int? length;
  final int? width;
  final int? price;
  final bool? sallableInPoints;
  final List<ProductGroup> group;
  final String? id;
  final int? priceAfterDiscount;

  ProductClass copyWith({
    String? size,
    int? length,
    int? width,
    int? price,
    bool? sallableInPoints,
    List<ProductGroup>? group,
    String? id,
    int? priceAfterDiscount,
  }) {
    return ProductClass(
      size: size ?? this.size,
      length: length ?? this.length,
      width: width ?? this.width,
      price: price ?? this.price,
      sallableInPoints: sallableInPoints ?? this.sallableInPoints,
      group: group ?? this.group,
      id: id ?? this.id,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
    );
  }

  factory ProductClass.fromJson(Map<String, dynamic> json) {
    return ProductClass(
      size: json["size"],
      length: json["length"],
      width: json["width"],
      price: json["price"],
      sallableInPoints: json["sallableInPoints"],
      group: json["group"] == null
          ? []
          : List<ProductGroup>.from(
              json["group"]!.map((x) => ProductGroup.fromJson(x))),
      id: json["_id"],
      priceAfterDiscount: json["priceAfterDiscount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "size": size,
        "length": length,
        "width": width,
        "price": price,
        "sallableInPoints": sallableInPoints,
        "group": group.map((x) => x.toJson()).toList(),
        "_id": id,
        "priceAfterDiscount": priceAfterDiscount,
      };

  @override
  String toString() {
    return "$size, $length, $width, $price, $sallableInPoints, $group, $id, $priceAfterDiscount, ";
  }
}

class ProductGroup {
  ProductGroup({
    required this.color,
    required this.quantity,
    required this.id,
  });

  final String? color;
  final int? quantity;
  final String? id;

  ProductGroup copyWith({
    String? color,
    int? quantity,
    String? id,
  }) {
    return ProductGroup(
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(
      color: json["color"],
      quantity: json["quantity"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "color": color,
        "quantity": quantity,
        "_id": id,
      };

  @override
  String toString() {
    return "$color, $quantity, $id, ";
  }
}
