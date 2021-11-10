class CoursesModel {
  List<CourseModel> courseModel = List<CourseModel>.empty(growable: true);

  CoursesModel({this.courseModel});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    if (json['courseModel'] != null) {
      courseModel = new List<CourseModel>.empty(growable: true);
      json['courseModel'].forEach((v) {
        courseModel.add(new CourseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseModel != null) {
      data['courseModel'] = this.courseModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseModel {
  int id = 0;
  String courseName = '';

  CourseModel({this.id, this.courseName});

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseName'] = this.courseName;
    return data;
  }
}
