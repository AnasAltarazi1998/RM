class MemberModel {
  int id = 0;
  String name = '';

  MemberModel({this.id, this.name});

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MembersModel {
  List<MemberModel> memberModel = List<MemberModel>.empty(growable: true);

  MembersModel({this.memberModel});

  MembersModel.fromJson(Map<String, dynamic> json) {
    if (json['memberModel'] != null) {
      memberModel = new List<MemberModel>.empty(growable: true);
      json['memberModel'].forEach((v) {
        memberModel.add(new MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memberModel != null) {
      data['memberModel'] = this.memberModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
