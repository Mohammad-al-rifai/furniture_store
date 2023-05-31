class AddOrderRequest {
  UserInfo? userInfo;
  ShippingAddress? shippingAddress;
  String? paymentMethod;

  AddOrderRequest({this.userInfo, this.shippingAddress, this.paymentMethod});

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

class UserInfo {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  UserInfo({this.firstName, this.lastName, this.email, this.phone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class ShippingAddress {
  String? country;
  String? city;
  String? region;
  String? streetNumber;
  String? houseNumber;
  String? description;

  ShippingAddress(
      {this.country,
      this.city,
      this.region,
      this.streetNumber,
      this.houseNumber,
      this.description});

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
