part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class FetchDataEvent extends DataEvent {}

class AddMemberEvent extends DataEvent {
  MemberModel memberModel;
  AddMemberEvent({this.memberModel});
}

class AddCourseEvent extends DataEvent {
  CourseModel courseModel;
  AddCourseEvent({this.courseModel});
}

class AddStatusEvent extends DataEvent {
  StatusModel statusModel;
  AddStatusEvent({this.statusModel});
}

class DeleteMemberEvent extends DataEvent {
  int id;
  DeleteMemberEvent({this.id});
}

class DeleteStatusEvent extends DataEvent {
  int id;
  DeleteStatusEvent({this.id});
}

class DeleteCourseEvent extends DataEvent {
  int id;
  DeleteCourseEvent({this.id});
}
