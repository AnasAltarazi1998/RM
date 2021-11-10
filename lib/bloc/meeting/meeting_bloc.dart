import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/model/member_with_status_models.dart';
import 'package:rm_app/service/form_service.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingInitial());
  FormService formService = FormService();
  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is AddMeetingEvent) {
      formService.save(event.formModel);
      yield MeetingAddedState(formModel: event.formModel);
    } else if (event is FetchMeetingEvent) {
      FormModel formModel = formService.findById(event.meetingId);
      yield MeetingLoadedState(formModel: formModel);
    } else if (event is AddMembersToMeetingEvent) {
      formService.addMembers(event.memberWithStatusList, event.formId);
      yield MembersAddedToMeetingState();
      this.add(FetchMeetingEvent(meetingId: event.formId));
    } else if (event is DeleteMeetingEvent) {
      formService.deleteById(event.id);
      yield MeetingDeletedState();
    } else if (event is DeleteMemberFromMeetingEvent) {
      formService.deleteMemberFromForm(event.memberId, event.meetingId);
      yield MemberDeletedFromMeetingState();
      this.add(FetchMeetingEvent(meetingId: event.meetingId));
    }
  }
}
