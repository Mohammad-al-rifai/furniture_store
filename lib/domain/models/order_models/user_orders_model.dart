class UserOrdersModel {
  String? message;
  bool? status;
  List<OrderData>? data;

  UserOrdersModel({this.message, this.status, this.data});

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  OrderUserInfo? userInfo;
  OrderShippingAddress? shippingAddress;
  String? sId;
  String? user;
  String? status;
  int? totalPrice;
  String? paymentMethod;
  String? paymentStatus;
  String? updatedAt;
  String? createdAt;
  int? iV;
  String? fullName;
  String? id;

  OrderData(
      {this.userInfo,
      this.shippingAddress,
      this.sId,
      this.user,
      this.status,
      this.totalPrice,
      this.paymentMethod,
      this.paymentStatus,
      this.updatedAt,
      this.createdAt,
      this.iV,
      this.fullName,
      this.id});

  OrderData.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? OrderUserInfo.fromJson(json['userInfo'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? OrderShippingAddress.fromJson(json['shippingAddress'])
        : null;
    sId = json['_id'];
    user = json['user'];
    status = json['status'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    fullName = json['fullName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['_id'] = sId;
    data['user'] = user;
    data['status'] = status;
    data['totalPrice'] = totalPrice;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['fullName'] = fullName;
    data['id'] = id;
    return data;
  }
}

class OrderUserInfo {
  String? firstName;
  String? lastName;
  String? email;
  int? phone;

  OrderUserInfo({this.firstName, this.lastName, this.email, this.phone});

  OrderUserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class OrderShippingAddress {
  String? country;
  String? city;
  String? region;
  int? streetNumber;
  int? houseNumber;
  String? description;

  OrderShippingAddress(
      {this.country,
      this.city,
      this.region,
      this.streetNumber,
      this.houseNumber,
      this.description});

  OrderShippingAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    region = json['region'];
    streetNumber = json['streetNumber'];
    houseNumber = json['houseNumber'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['city'] = city;
    data['region'] = region;
    data['streetNumber'] = streetNumber;
    data['houseNumber'] = houseNumber;
    data['description'] = description;
    return data;
  }
}
