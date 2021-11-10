class StatusModel {
  int id = 0;
  String status = '';

  StatusModel({this.id, this.status});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}

class StatusesModel {
  List<StatusModel> statusModel = List<StatusModel>.empty(growable: true);

  StatusesModel({this.statusModel});

  StatusesModel.fromJson(Map<String, dynamic> json) {
    if (json['statusModel'] != null) {
      statusModel = new List<StatusModel>.empty(growable: true);
      json['statusModel'].forEach((v) {
        statusModel.add(new StatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statusModel != null) {
      data['statusModel'] = this.statusModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
