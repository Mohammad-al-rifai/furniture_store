class OrderAdvancedSearchModel {
  OrderAdvancedSearchModel({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final List<Datum>? data;

  factory OrderAdvancedSearchModel.fromJson(Map<String, dynamic> json) {
    return OrderAdvancedSearchModel(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
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
    required this.shippingDate,
    required this.fullName,
    required this.datumId,
  });

  final UserInfo? userInfo;
  final ShippingAddress? shippingAddress;
  final String? id;
  final String? user;
  final List<Item> items;
  final String? status;
  final int? totalPrice;
  final String? paymentMethod;
  final String? paymentStatus;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? v;
  final DateTime? shippingDate;
  final String? fullName;
  final String? datumId;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      userInfo:
          json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
      shippingAddress: json["shippingAddress"] == null
          ? null
          : ShippingAddress.fromJson(json["shippingAddress"]),
      id: json["_id"],
      user: json["user"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      status: json["status"],
      totalPrice: json["totalPrice"],
      paymentMethod: json["paymentMethod"],
      paymentStatus: json["paymentStatus"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
      shippingDate: DateTime.tryParse(json["shippingDate"] ?? ""),
      fullName: json["fullName"],
      datumId: json["id"],
    );
  }
}

class Item {
  Item({
    required this.product,
    required this.itemClass,
    required this.group,
    required this.quantity,
    required this.price,
    required this.id,
    required this.itemId,
  });

  final String? product;
  final String? itemClass;
  final String? group;
  final int? quantity;
  final int? price;
  final String? id;
  final String? itemId;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      product: json["product"],
      itemClass: json["class"],
      group: json["group"],
      quantity: json["quantity"],
      price: json["price"],
      id: json["_id"],
      itemId: json["id"],
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
