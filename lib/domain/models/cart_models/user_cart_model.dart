class UserCartModel {
  UserCartModel({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final UserCartData? data;

  factory UserCartModel.fromJson(Map<String, dynamic> json) {
    return UserCartModel(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null ? null : UserCartData.fromJson(json["data"]),
    );
  }
}

class UserCartData {
  UserCartData({
    required this.items,
    required this.totalPrice,
  });

  final List<UserCartItem> items;
  final int? totalPrice;

  factory UserCartData.fromJson(Map<String, dynamic> json) {
    return UserCartData(
      items: json["items"] == null
          ? []
          : List<UserCartItem>.from(
              json["items"]!.map((x) => UserCartItem.fromJson(x))),
      totalPrice: json["totalPrice"],
    );
  }
}

class UserCartItem {
  UserCartItem({
    required this.product,
    required this.itemClass,
    required this.group,
    required this.itemID,
    required this.quantity,
  });

  final UserCartProduct? product;
  final UserCartClass? itemClass;
  final UserCartGroup? group;
  final String? itemID;
  final int? quantity;

  factory UserCartItem.fromJson(Map<String, dynamic> json) {
    return UserCartItem(
      product: json["product"] == null
          ? null
          : UserCartProduct.fromJson(json["product"]),
      itemClass:
          json["class"] == null ? null : UserCartClass.fromJson(json["class"]),
      group:
          json["group"] == null ? null : UserCartGroup.fromJson(json["group"]),
      itemID: json['itemID'],
      quantity: json['quantity'],
    );
  }
}

class UserCartGroup {
  UserCartGroup({
    required this.color,
    required this.quantity,
    required this.id,
  });

  final String? color;
  final int? quantity;
  final String? id;

  factory UserCartGroup.fromJson(Map<String, dynamic> json) {
    return UserCartGroup(
      color: json["color"],
      quantity: json["quantity"],
      id: json["_id"],
    );
  }
}

class UserCartClass {
  UserCartClass({
    required this.size,
    required this.length,
    required this.width,
    required this.price,
    required this.sallableInPoints,
    required this.id,
  });

  final String? size;
  final int? length;
  final int? width;
  final int? price;
  final bool? sallableInPoints;
  final String? id;

  factory UserCartClass.fromJson(Map<String, dynamic> json) {
    return UserCartClass(
      size: json["size"],
      length: json["length"],
      width: json["width"],
      price: json["price"],
      sallableInPoints: json["sallableInPoints"],
      id: json["_id"],
    );
  }
}

class UserCartProduct {
  UserCartProduct({
    required this.id,
    required this.name,
    required this.descreption,
    required this.mainCategorie,
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
  final List<String> gallery;
  final String? ownerId;
  final bool? homePage;
  final int? guarantee;
  final String? manufacturingMaterial;
  final List<UserCartOffer> offers;
  final List<UserCartDeliveryArea> deliveryAreas;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;
  final String? mainImage;
  final String? mainVideo;
  final String? vrImage;
  final String? arImage;

  factory UserCartProduct.fromJson(Map<String, dynamic> json) {
    return UserCartProduct(
      id: json["_id"],
      name: json["name"],
      descreption: json["descreption"],
      mainCategorie: json["mainCategorie"],
      gallery: json["gallery"] == null
          ? []
          : List<String>.from(json["gallery"]!.map((x) => x)),
      ownerId: json["owner_id"],
      homePage: json["HomePage"],
      guarantee: json["Guarantee"],
      manufacturingMaterial: json["manufacturingMaterial"],
      offers: json["offers"] == null
          ? []
          : List<UserCartOffer>.from(
              json["offers"]!.map((x) => UserCartOffer.fromJson(x))),
      deliveryAreas: json["deliveryAreas"] == null
          ? []
          : List<UserCartDeliveryArea>.from(json["deliveryAreas"]!
              .map((x) => UserCartDeliveryArea.fromJson(x))),
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

class UserCartDeliveryArea {
  UserCartDeliveryArea({
    required this.location,
    required this.deliveryPrice,
    required this.id,
  });

  final String? location;
  final int? deliveryPrice;
  final String? id;

  factory UserCartDeliveryArea.fromJson(Map<String, dynamic> json) {
    return UserCartDeliveryArea(
      location: json["location"],
      deliveryPrice: json["deliveryPrice"],
      id: json["_id"],
    );
  }
}

class UserCartOffer {
  UserCartOffer({
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

  factory UserCartOffer.fromJson(Map<String, dynamic> json) {
    return UserCartOffer(
      valueOfOffer: json["valueOfOffer"],
      typeOfOffer: json["typeOfOffer"],
      startDateOfOffers: DateTime.tryParse(json["startDateOfOffers"] ?? ""),
      endDateOfOffers: DateTime.tryParse(json["endDateOfOffers"] ?? ""),
      activeUser: json["ActiveUser"],
      id: json["_id"],
    );
  }
}
