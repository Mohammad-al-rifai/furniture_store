class ProHistoryModel {
  bool? status;
  List<ProHistoryData>? data;

  ProHistoryModel({this.status, this.data});

  ProHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProHistoryData>[];
      json['data'].forEach((v) {
        data!.add(ProHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProHistoryData {
  String? quantity;
  String? price;
  String? timestamp;
  String? size;
  String? manufacturingMaterial;
  String? state;
  String? seller;
  String? blockNumber;
  String? Guarantee;

  ProHistoryData({
    this.quantity,
    this.price,
    this.timestamp,
    this.size,
    this.manufacturingMaterial,
    this.state,
    this.seller,
    this.blockNumber,
    this.Guarantee,
  });

  ProHistoryData.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    timestamp = json['timestamp'];
    size = json['size'];
    manufacturingMaterial = json['manufacturingMaterial'];
    state = json['state'];
    seller = json['seller'];
    blockNumber = json['blockNumber'];
    Guarantee = json['Guarantee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['price'] = price;
    data['timestamp'] = timestamp;
    data['size'] = size;
    data['manufacturingMaterial'] = manufacturingMaterial;
    data['state'] = state;
    data['seller'] = seller;
    data['blockNumber'] = blockNumber;
    data['Guarantee'] = Guarantee;
    return data;
  }
}
