class HomeScreenModel {
  List<HomeScreenCourseModel> homeScreenCourseModel;
}

class HomeScreenCourseModel {
  String courseName;
  String courseDate;
  String membersCount;

  HomeScreenCourseModel({this.courseName, this.courseDate, this.membersCount});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseName'] = courseName;
    data['courseDate'] = courseDate;
    data['membersCount'] = membersCount;
    return data;
  }

  HomeScreenCourseModel.fromJson(Map<String, dynamic> json) {
    courseName = json['courseName'];
    courseDate = json['courseDate'];
    membersCount = json['membersCount'];
  }
}
