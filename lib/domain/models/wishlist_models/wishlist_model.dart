class WishlistModel {
  WishlistModel({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final WishlistData? data;

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null ? null : WishlistData.fromJson(json["data"]),
    );
  }
}

class WishlistData {
  WishlistData({
    required this.id,
    required this.ownerId,
    required this.products,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final WishlistOwnerId? ownerId;
  final List<WishlistProduct> products;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;

  factory WishlistData.fromJson(Map<String, dynamic> json) {
    return WishlistData(
      id: json["_id"],
      ownerId: json["owner_id"] == null
          ? null
          : WishlistOwnerId.fromJson(json["owner_id"]),
      products: json["products"] == null
          ? []
          : List<WishlistProduct>.from(
              json["products"]!.map((x) => WishlistProduct.fromJson(x))),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class WishlistOwnerId {
  WishlistOwnerId({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.address,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final String? fullName;
  final String? email;
  final int? role;
  final String? address;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;

  factory WishlistOwnerId.fromJson(Map<String, dynamic> json) {
    return WishlistOwnerId(
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      role: json["role"],
      address: json["address"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class WishlistProduct {
  WishlistProduct({
    required this.productId,
  });

  final WishlistProductId? productId;

  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      productId: json["product_id"] == null
          ? null
          : WishlistProductId.fromJson(json["product_id"]),
    );
  }
}

class WishlistProductId {
  WishlistProductId({
    required this.id,
    required this.name,
    required this.descreption,
    required this.mainCategorie,
    required this.productIdClass,
    required this.gallery,
    required this.ownerId,
    required this.homePage,
    required this.guarantee,
    required this.manufacturingMaterial,
    required this.offers,
    required this.deliveryAreas,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
    required this.mainImage,
    required this.mainVideo,
    required this.vrImage,
    required this.arImage,
  });

  final String? id;
  final String? name;
  final String? descreption;
  final String? mainCategorie;
  final List<WishlistClass> productIdClass;
  final List<String> gallery;
  final String? ownerId;
  final bool? homePage;
  final int? guarantee;
  final String? manufacturingMaterial;
  final List<WishlistOffer> offers;
  final List<WishlistDeliveryArea> deliveryAreas;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;
  final String? mainImage;
  final String? mainVideo;
  final String? vrImage;
  final String? arImage;

  factory WishlistProductId.fromJson(Map<String, dynamic> json) {
    return WishlistProductId(
      id: json["_id"],
      name: json["name"],
      descreption: json["descreption"],
      mainCategorie: json["mainCategorie"],
      productIdClass: json["Class"] == null
          ? []
          : List<WishlistClass>.from(
              json["Class"]!.map((x) => WishlistClass.fromJson(x))),
      gallery: json["gallery"] == null
          ? []
          : List<String>.from(json["gallery"]!.map((x) => x)),
      ownerId: json["owner_id"],
      homePage: json["HomePage"],
      guarantee: json["Guarantee"],
      manufacturingMaterial: json["manufacturingMaterial"],
      offers: json["offers"] == null
          ? []
          : List<WishlistOffer>.from(
              json["offers"]!.map((x) => WishlistOffer.fromJson(x))),
      deliveryAreas: json["deliveryAreas"] == null
          ? []
          : List<WishlistDeliveryArea>.from(json["deliveryAreas"]!
              .map((x) => WishlistDeliveryArea.fromJson(x))),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
      mainImage: json["mainImage"],
      mainVideo: json["mainVideo"],
      vrImage: json["vrImage"],
      arImage: json["arImage"],
    );
  }
}

class WishlistDeliveryArea {
  WishlistDeliveryArea({
    required this.location,
    required this.deliveryPrice,
    required this.id,
  });

  final String? location;
  final int? deliveryPrice;
  final String? id;

  factory WishlistDeliveryArea.fromJson(Map<String, dynamic> json) {
    return WishlistDeliveryArea(
      location: json["location"],
      deliveryPrice: json["deliveryPrice"],
      id: json["_id"],
    );
  }
}

class WishlistOffer {
  WishlistOffer({
    required this.valueOfOffer,
    required this.typeOfOffer,
    required this.startDateOfOffers,
    required this.endDateOfOffers,
    required this.activeUser,
    required this.id,
  });

  final int? valueOfOffer;
  final String? typeOfOffer;
  final DateTime? startDateOfOffers;
  final DateTime? endDateOfOffers;
  final bool? activeUser;
  final String? id;

  factory WishlistOffer.fromJson(Map<String, dynamic> json) {
    return WishlistOffer(
      valueOfOffer: json["valueOfOffer"],
      typeOfOffer: json["typeOfOffer"],
      startDateOfOffers: DateTime.tryParse(json["startDateOfOffers"] ?? ""),
      endDateOfOffers: DateTime.tryParse(json["endDateOfOffers"] ?? ""),
      activeUser: json["ActiveUser"],
      id: json["_id"],
    );
  }
}

class WishlistClass {
  WishlistClass({
    required this.size,
    required this.length,
    required this.width,
    required this.price,
    required this.sallableInPoints,
    required this.group,
    required this.id,
  });

  final String? size;
  final int? length;
  final int? width;
  final int? price;
  final bool? sallableInPoints;
  final List<WishlistGroup> group;
  final String? id;

  factory WishlistClass.fromJson(Map<String, dynamic> json) {
    return WishlistClass(
      size: json["size"],
      length: json["length"],
      width: json["width"],
      price: json["price"],
      sallableInPoints: json["sallableInPoints"],
      group: json["group"] == null
          ? []
          : List<WishlistGroup>.from(
              json["group"]!.map((x) => WishlistGroup.fromJson(x))),
      id: json["_id"],
    );
  }
}

class WishlistGroup {
  WishlistGroup({
    required this.color,
    required this.quantity,
    required this.id,
  });

  final String? color;
  final int? quantity;
  final String? id;

  factory WishlistGroup.fromJson(Map<String, dynamic> json) {
    return WishlistGroup(
      color: json["color"],
      quantity: json["quantity"],
      id: json["_id"],
    );
  }
}
