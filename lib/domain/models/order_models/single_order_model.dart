class SingleOrderModel {
  SingleOrderModel({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final SingleOrderData? data;

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) {
    return SingleOrderModel(
      message: json["message"],
      status: json["status"],
      data:
          json["data"] == null ? null : SingleOrderData.fromJson(json["data"]),
    );
  }
}

class SingleOrderData {
  SingleOrderData({
    required this.userInfo,
    required this.shippingAddress,
    required this.id,
    required this.user,
    required this.items,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
  });

  final UserInfo? userInfo;
  final ShippingAddress? shippingAddress;
  final String? id;
  final String? user;
  final List<SingleOrderItem> items;
  final String? status;
  final int? totalPrice;
  final String? paymentMethod;
  final String? paymentStatus;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;

  factory SingleOrderData.fromJson(Map<String, dynamic> json) {
    return SingleOrderData(
      userInfo:
          json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
      shippingAddress: json["shippingAddress"] == null
          ? null
          : ShippingAddress.fromJson(json["shippingAddress"]),
      id: json["_id"],
      user: json["user"],
      items: json["items"] == null
          ? []
          : List<SingleOrderItem>.from(
              json["items"]!.map((x) => SingleOrderItem.fromJson(x))),
      status: json["status"],
      totalPrice: json["totalPrice"],
      paymentMethod: json["paymentMethod"],
      paymentStatus: json["paymentStatus"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class SingleOrderItem {
  SingleOrderItem({
    required this.quantity,
    required this.price,
    required this.id,
    required this.singleProduct,
  });

  final int? quantity;
  final int? price;
  final String? id;
  final SingleProduct? singleProduct;

  factory SingleOrderItem.fromJson(Map<String, dynamic> json) {
    return SingleOrderItem(
      quantity: json["quantity"],
      price: json["price"],
      id: json["_id"],
      singleProduct: json["singleProduct"] == null
          ? null
          : SingleProduct.fromJson(json["singleProduct"]),
    );
  }
}

class SingleProduct {
  SingleProduct({
    required this.product,
    required this.singleProductClass,
    required this.group,
    required this.guarantee,
    required this.ownerProduct,
  });

  final Product? product;
  final Class? singleProductClass;
  final Group? group;
  final int? guarantee;
  final OwnerProduct? ownerProduct;

  factory SingleProduct.fromJson(Map<String, dynamic> json) {
    return SingleProduct(
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
      singleProductClass:
          json["class"] == null ? null : Class.fromJson(json["class"]),
      group: json["group"] == null ? null : Group.fromJson(json["group"]),
      guarantee: json["Guarantee"],
      ownerProduct: json["ownerProduct"] == null
          ? null
          : OwnerProduct.fromJson(json["ownerProduct"]),
    );
  }
}

class Group {
  Group({
    required this.color,
    required this.id,
  });

  final String? color;
  final String? id;

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      color: json["color"],
      id: json["_id"],
    );
  }
}

class OwnerProduct {
  OwnerProduct({
    required this.kycDoucoments,
    required this.id,
    required this.fullName,
    required this.email,
    required this.marketName,
    required this.marketLogo,
    required this.phone,
    required this.role,
    required this.address,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
  });

  final KycDoucoments? kycDoucoments;
  final String? id;
  final String? fullName;
  final String? email;
  final String? marketName;
  final String? marketLogo;
  final String? phone;
  final int? role;
  final String? address;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;

  factory OwnerProduct.fromJson(Map<String, dynamic> json) {
    return OwnerProduct(
      kycDoucoments: json["kycDoucoments"] == null
          ? null
          : KycDoucoments.fromJson(json["kycDoucoments"]),
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      marketName: json["marketName"],
      marketLogo: json["marketLogo"],
      phone: json["phone"],
      role: json["role"],
      address: json["address"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class KycDoucoments {
  KycDoucoments({
    required this.businesslicense,
    required this.nameOfBank,
    required this.nameOfBrand,
    required this.iban,
    required this.addressOfBank,
  });

  final String? businesslicense;
  final String? nameOfBank;
  final String? nameOfBrand;
  final String? iban;
  final String? addressOfBank;

  factory KycDoucoments.fromJson(Map<String, dynamic> json) {
    return KycDoucoments(
      businesslicense: json["businesslicense"],
      nameOfBank: json["nameOFBank"],
      nameOfBrand: json["nameOfBrand"],
      iban: json["iban"],
      addressOfBank: json["addressOfBank"],
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.descreption,
    required this.mainCategorie,
    required this.gallery,
    required this.ownerId,
    required this.homePage,
    required this.guarantee,
    required this.manufacturingMaterial,
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
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;
  final String? mainImage;
  final String? mainVideo;
  final String? vrImage;
  final String? arImage;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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

class Class {
  Class({
    required this.size,
    required this.length,
    required this.width,
    required this.id,
  });

  final String? size;
  final int? length;
  final int? width;
  final String? id;

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      size: json["size"],
      length: json["length"],
      width: json["width"],
      id: json["_id"],
    );
  }
}

class ShippingAddress {
  ShippingAddress({
    required this.country,
    required this.city,
    required this.region,
    required this.streetNumber,
    required this.houseNumber,
    required this.description,
  });

  final String? country;
  final String? city;
  final String? region;
  final int? streetNumber;
  final int? houseNumber;
  final String? description;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      country: json["country"],
      city: json["city"],
      region: json["region"],
      streetNumber: json["streetNumber"],
      houseNumber: json["houseNumber"],
      description: json["description"],
    );
  }
}

class UserInfo {
  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final int? phone;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
    );
  }
}
