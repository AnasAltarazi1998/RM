import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/model/member_with_status_models.dart';
import 'package:rm_app/model/student_with_status_model.dart';

class FormModel {
  int id = 0;
  CourseModel course = CourseModel();
  String date = '';
  List<MemberWithStatusModel> members =
      List<MemberWithStatusModel>.empty(growable: true);
  List<StudentWithStatusModel> students =
      List<StudentWithStatusModel>.empty(growable: true);

  FormModel({this.id, this.course, this.date, this.members});

  FormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course =
        json['course'] != null ? CourseModel.fromJson(json['course']) : null;
    date = json['Date'];
    if (json['members'] != null) {
      members = new List<MemberWithStatusModel>.empty(growable: true);
      json['members'].forEach((v) {
        members.add(new MemberWithStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course'] = this.course;
    data['Date'] = this.date;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormsModel {
  List<FormModel> formModel = List<FormModel>.empty(growable: true);

  FormsModel({this.formModel});

  FormsModel.fromJson(Map<String, dynamic> json) {
    if (json['formModel'] != null) {
      formModel = new List<FormModel>.empty(growable: true);
      json['formModel'].forEach((v) {
        formModel.add(new FormModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.formModel != null) {
      data['formModel'] = this.formModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
