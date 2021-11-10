import 'package:rm_app/model/status_models.dart';

class MemberWithStatusModel {
  int id = 0;
  String name = '';
  StatusModel statusModel = StatusModel();

  MemberWithStatusModel({this.id, this.name, this.statusModel});

  MemberWithStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statusModel = json['statusModel'] != null
        ? new StatusModel.fromJson(json['statusModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.statusModel != null) {
      data['statusModel'] = this.statusModel.toJson();
    }
    return data;
  }
}

class MembesrWithStatusModel {
  List<MemberWithStatusModel> memberWithStatusModel =
      List<MemberWithStatusModel>.empty(growable: true);

  MembesrWithStatusModel({this.memberWithStatusModel});

  MembesrWithStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['memberWithStatusModel'] != null) {
      memberWithStatusModel =
          new List<MemberWithStatusModel>.empty(growable: true);
      json['memberWithStatusModel'].forEach((v) {
        memberWithStatusModel.add(new MemberWithStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memberWithStatusModel != null) {
      data['memberWithStatusModel'] =
          this.memberWithStatusModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
