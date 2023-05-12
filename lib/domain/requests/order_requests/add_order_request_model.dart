class AddOrderRequestModel {
  AddOrderRequestUserInfo? userInfo;
  AddOrderRequestShippingAddress? shippingAddress;
  String? paymentMethod;

  AddOrderRequestModel(
      {this.userInfo, this.shippingAddress, this.paymentMethod});

  AddOrderRequestModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? AddOrderRequestUserInfo.fromJson(json['userInfo'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? AddOrderRequestShippingAddress.fromJson(json['shippingAddress'])
        : null;
    paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['paymentMethod'] = paymentMethod;
    return data;
  }
}

class AddOrderRequestUserInfo {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  AddOrderRequestUserInfo(
      {this.firstName, this.lastName, this.email, this.phone});

  AddOrderRequestUserInfo.fromJson(Map<String, dynamic> json) {
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

class AddOrderRequestShippingAddress {
  String? country;
  String? city;
  String? region;
  String? streetNumber;
  String? houseNumber;
  String? description;

  AddOrderRequestShippingAddress(
      {this.country,
      this.city,
      this.region,
      this.streetNumber,
      this.houseNumber,
      this.description});

  AddOrderRequestShippingAddress.fromJson(Map<String, dynamic> json) {
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
