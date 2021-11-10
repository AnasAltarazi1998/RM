class StudentModel {
  int id = 0;
  String name = '';

  StudentModel({this.id, this.name});

  StudentModel.fromJson(Map<String, dynamic> json) {
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

class StudentsModel {
  List<StudentModel> studentModel = List<StudentModel>.empty(growable: true);

  StudentsModel({this.studentModel});

  StudentsModel.fromJson(Map<String, dynamic> json) {
    if (json['StudentModel'] != null) {
      studentModel = new List<StudentModel>.empty(growable: true);
      json['StudentModel'].forEach((v) {
        studentModel.add(new StudentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentModel != null) {
      data['StudentModel'] = this.studentModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
