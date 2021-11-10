part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingCoursesDetailsState extends HomeInitial {}

class CourseDetailsLoadedState extends HomeInitial {
  List<FormModel> formsModel;
  CourseDetailsLoadedState({this.formsModel});
}

class CourseDetailsErrorState extends HomeInitial {
  String errorMessage;
  CourseDetailsErrorState({this.errorMessage});
}
