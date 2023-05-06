class VRModel {
  String? message;
  bool? status;
  VRData? data;

  VRModel({this.message, this.status, this.data});

  VRModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? VRData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VRData {
  VrImage? vrImage;

  VRData({this.vrImage});

  VRData.fromJson(Map<String, dynamic> json) {
    vrImage =
        json['vrImage'] != null ? VrImage.fromJson(json['vrImage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (vrImage != null) {
      data['vrImage'] = vrImage!.toJson();
    }
    return data;
  }
}

class VrImage {
  String? sId;
  String? vrImage;

  VrImage({this.sId, this.vrImage});

  VrImage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vrImage = json['vrImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vrImage'] = vrImage;
    return data;
  }
}
