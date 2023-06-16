class FeaturesModel {
  String? message;
  bool? status;
  List<FeatureData>? data;

  FeaturesModel({this.message, this.status, this.data});

  FeaturesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <FeatureData>[];
      json['data'].forEach((v) {
        data!.add(FeatureData.fromJson(v));
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

class FeatureData {
  String? sId;
  String? title;
  String? description;
  String? icon;
  String? language;
  String? updatedAt;
  String? createdAt;
  int? iV;

  FeatureData(
      {this.sId,
      this.title,
      this.description,
      this.icon,
      this.language,
      this.updatedAt,
      this.createdAt,
      this.iV});

  FeatureData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    language = json['language'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    data['language'] = language;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
