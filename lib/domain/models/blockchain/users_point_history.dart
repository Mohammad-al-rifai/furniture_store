class UsersPointsModel {
  bool? status;
  List<UsersPointsData>? data;

  UsersPointsModel({this.status, this.data});

  UsersPointsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UsersPointsData>[];
      json['data'].forEach((v) {
        data!.add(UsersPointsData.fromJson(v));
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

class UsersPointsData {
  String? points;
  String? timestamp;
  String? status;

  UsersPointsData({this.points, this.timestamp, this.status});

  UsersPointsData.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['points'] = points;
    data['timestamp'] = timestamp;
    data['status'] = status;
    return data;
  }
}
