class ARModel {
  String? message;
  bool? status;
  ARData? data;

  ARModel({this.message, this.status, this.data});

  ARModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? ARData.fromJson(json['data']) : null;
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

class ARData {
  ArImage? arImage;

  ARData({this.arImage});

  ARData.fromJson(Map<String, dynamic> json) {
    arImage =
        json['arImage'] != null ? ArImage.fromJson(json['arImage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (arImage != null) {
      data['arImage'] = arImage!.toJson();
    }
    return data;
  }
}

class ArImage {
  String? sId;
  String? arImage;

  ArImage({this.sId, this.arImage});

  ArImage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    arImage = json['arImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['arImage'] = arImage;
    return data;
  }
}
