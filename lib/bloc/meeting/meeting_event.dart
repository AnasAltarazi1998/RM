part of 'meeting_bloc.dart';

@immutable
abstract class MeetingEvent {}

class AddMeetingEvent extends MeetingEvent {
  final FormModel formModel;
  AddMeetingEvent({this.formModel});
}

class FetchMeetingEvent extends MeetingEvent {
  final int meetingId;
  FetchMeetingEvent({this.meetingId});
}

class AddMembersToMeetingEvent extends MeetingEvent {
  final List<MemberWithStatusModel> memberWithStatusList;
  final int formId;
  AddMembersToMeetingEvent({this.memberWithStatusList, this.formId});
}

class DeleteMeetingEvent extends MeetingEvent {
  final int id;
  DeleteMeetingEvent({this.id});
}

class DeleteMemberFromMeetingEvent extends MeetingEvent {
  final int memberId;
  final int meetingId;
  DeleteMemberFromMeetingEvent({this.memberId, this.meetingId});
}
