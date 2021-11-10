part of 'meeting_bloc.dart';

@immutable
abstract class MeetingState {}

class MeetingInitial extends MeetingState {}

class MeetingAddedState extends MeetingState {
  FormModel formModel;
  MeetingAddedState({this.formModel});
}

class MeetingLoadedState extends MeetingState {
  FormModel formModel;
  MeetingLoadedState({this.formModel});
}

class MeetingLoadingState extends MeetingState {}

class MembersAddedToMeetingState extends MeetingState {}

class MeetingDeletedState extends MeetingState {}

class MemberDeletedFromMeetingState extends MeetingState {}
