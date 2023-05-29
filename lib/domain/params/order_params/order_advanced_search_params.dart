class OrderAdvancedSearchParams {
  int? page = 1;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? status;
  int? totalPrice;
  String? country;
  String? city;
  String? region;
  int? streetNumber;
  int? houseNumber;
  String? paymentMethod;
  String? paymentStatus;

  OrderAdvancedSearchParams({
    this.page,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.status,
    this.totalPrice,
    this.country,
    this.city,
    this.region,
    this.streetNumber,
    this.houseNumber,
    this.paymentMethod,
    this.paymentStatus,
  });

  Map<String, dynamic> toJson() => {
        if (page != null) 'page': page,
        if (firstName != null && firstName!.isNotEmpty) 'firstName': firstName,
        if (lastName != null && lastName!.isNotEmpty) 'lastName': lastName,
        if (email != null && email!.isNotEmpty) 'email': email,
        if (phone != null && phone!.isNotEmpty) 'phone': phone,
        if (status != null && status!.isNotEmpty) 'status': status,
        if (totalPrice != null) 'totalPrice': totalPrice,
        if (country != null && country!.isNotEmpty) 'country': country,
        if (city != null && city!.isNotEmpty) 'city': city,
        if (region != null && region!.isNotEmpty) 'region': region,
        if (streetNumber != null) 'streetNumber': streetNumber,
        if (houseNumber != null) 'houseNumber': houseNumber,
        if (paymentMethod != null && paymentMethod!.isNotEmpty)
          'paymentMethod': paymentMethod,
        if (paymentStatus != null && paymentStatus!.isNotEmpty)
          'paymentStatus': paymentStatus,
      };

  factory OrderAdvancedSearchParams.fromJson(Map<String, dynamic> json) {
    return OrderAdvancedSearchParams(
      page: json['page'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      totalPrice: json['totalPrice'],
      country: json['country'],
      city: json['city'],
      region: json['region'],
      streetNumber: json['streetNumber'],
      houseNumber: json['houseNumber'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
    );
  }
}
