class SingleProModel {
  SingleProModel({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final SingleProData? data;

  factory SingleProModel.fromJson(Map<String, dynamic> json) {
    return SingleProModel(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null ? null : SingleProData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class SingleProData {
  SingleProData({
    required this.product,
  });

  final SingleProduct? product;

  factory SingleProData.fromJson(Map<String, dynamic> json) {
    return SingleProData(
      product: json["product"] == null
          ? null
          : SingleProduct.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
      };
}

class SingleProduct {
  SingleProduct({
    this.id,
    this.name,
    this.descreption,
    this.mainCategorie,
    this.productClass,
    this.ownerId,
    this.guarantee,
    this.manufacturingMaterial,
    this.deliveryAreas,
  });

  final String? id;
  final String? name;
  final String? descreption;
  final String? mainCategorie;
  final List<SingleProClass>? productClass;
  final SingleProOwnerId? ownerId;
  final int? guarantee;
  final String? manufacturingMaterial;
  final List<SingleProDeliveryArea>? deliveryAreas;

  factory SingleProduct.fromJson(Map<String, dynamic> json) {
    return SingleProduct(
      id: json["_id"],
      name: json["name"],
      descreption: json["descreption"],
      mainCategorie: json["mainCategorie"],
      productClass: json["Class"] == null
          ? []
          : List<SingleProClass>.from(
              json["Class"]!.map((x) => SingleProClass.fromJson(x))),
      ownerId: json["owner_id"] == null
          ? null
          : SingleProOwnerId.fromJson(json["owner_id"]),
      guarantee: json["Guarantee"],
      manufacturingMaterial: json["manufacturingMaterial"],
      deliveryAreas: json["deliveryAreas"] == null
          ? []
          : List<SingleProDeliveryArea>.from(json["deliveryAreas"]!
              .map((x) => SingleProDeliveryArea.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "descreption": descreption,
        "mainCategorie": mainCategorie,
        "Class": productClass?.map((x) => x.toJson()).toList(),
        "owner_id": ownerId?.toJson(),
        "Guarantee": guarantee,
        "manufacturingMaterial": manufacturingMaterial,
        "deliveryAreas": deliveryAreas?.map((x) => x.toJson()).toList(),
      };
}

class SingleProDeliveryArea {
  SingleProDeliveryArea({
    required this.location,
    required this.deliveryPrice,
    required this.id,
  });

  final String? location;
  final int? deliveryPrice;
  final String? id;

  factory SingleProDeliveryArea.fromJson(Map<String, dynamic> json) {
    return SingleProDeliveryArea(
      location: json["location"],
      deliveryPrice: json["deliveryPrice"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "location": location,
        "deliveryPrice": deliveryPrice,
        "_id": id,
      };
}

class SingleProOwnerId {
  SingleProOwnerId({
    required this.id,
    required this.fullName,
  });

  final String? id;
  final String? fullName;

  factory SingleProOwnerId.fromJson(Map<String, dynamic> json) {
    return SingleProOwnerId(
      id: json["_id"],
      fullName: json["fullName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
      };
}

class SingleProClass {
  SingleProClass({
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
  final List<SingleProGroup> group;
  final String? id;
  final int? priceAfterDiscount;

  factory SingleProClass.fromJson(Map<String, dynamic> json) {
    return SingleProClass(
      size: json["size"],
      length: json["length"],
      width: json["width"],
      price: json["price"],
      sallableInPoints: json["sallableInPoints"],
      group: json["group"] == null
          ? []
          : List<SingleProGroup>.from(
              json["group"]!.map((x) => SingleProGroup.fromJson(x))),
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
}

class SingleProGroup {
  SingleProGroup({
    required this.color,
    required this.quantity,
    required this.id,
  });

  final String? color;
  final int? quantity;
  final String? id;

  factory SingleProGroup.fromJson(Map<String, dynamic> json) {
    return SingleProGroup(
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
}
