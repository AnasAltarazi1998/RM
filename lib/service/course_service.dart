import 'dart:convert';

import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/service/init_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseService {
  static SharedPreferences _sharedPreferences;
  InitService initService = InitService();
  static void _init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();
  CourseService() {
    _init();
  }
  Future<bool> save(CourseModel course) {
    course.id = initService.generateId();
    String courses = _sharedPreferences.getString('courses');
    CoursesModel coursesModel = CoursesModel.fromJson(jsonDecode(courses));
    coursesModel.courseModel.add(course);
    return _sharedPreferences.setString(
        'courses', '${jsonEncode(coursesModel)}');
  }

  Future<bool> saveAll(List<CourseModel> members) {
    List<CourseModel> oldCourses = findAll();
    oldCourses.addAll(members);
    CoursesModel coursesModel = new CoursesModel(courseModel: oldCourses);

    return _sharedPreferences.setString(
        'courses', '${jsonEncode(coursesModel)}');
  }

  CourseModel findById(int id) {
    String courses = _sharedPreferences.getString('courses');
    CoursesModel coursesModel = CoursesModel.fromJson(jsonDecode(courses));
    return coursesModel.courseModel.where((element) => element.id == id).first;
  }

  List<CourseModel> findAll() {
    String courses = _sharedPreferences.getString('courses');
    CoursesModel coursesModel = CoursesModel.fromJson(jsonDecode(courses));
    return coursesModel.courseModel;
  }

  Future<bool> deleteById(int id) {
    List<CourseModel> oldCourses = findAll();
    oldCourses.removeWhere((element) => element.id == id);
    CoursesModel coursesModel = CoursesModel(courseModel: oldCourses);
    return _sharedPreferences.setString(
        'courses', '${jsonEncode(coursesModel)}');
  }
}
