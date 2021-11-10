part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class LoadingDataState extends DataState {}

class DataLoadedState extends DataState {
  List<MemberModel> membersList;
  List<StatusModel> statusList;
  List<CourseModel> courseList;
  DataLoadedState({this.courseList, this.membersList, this.statusList});
}

class DataErrorState extends DataState {}

class MemberAddedState extends DataState {}

class CourseAddedState extends DataState {}

class StatusAddedState extends DataState {}

class MemberDeletedState extends DataState {}

class CourseDeletedState extends DataState {}

class StatusDeletedState extends DataState {}
