import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/model/member_models.dart';
import 'package:rm_app/model/status_models.dart';
import 'package:rm_app/service/course_service.dart';
import 'package:rm_app/service/member_service.dart';
import 'package:rm_app/service/status_srevice.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial());
  final CourseService _courseService = CourseService();
  final MemberService _memberService = MemberService();
  final StatusService _statusService = StatusService();
  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      yield LoadingDataState();
      yield DataLoadedState(
        courseList: _courseService.findAll() ?? List.empty(growable: true),
        membersList: _memberService.findAll() ?? List.empty(growable: true),
        statusList: _statusService.findAll() ?? List.empty(growable: true),
      );
    } else if (event is AddMemberEvent) {
      _memberService.save(event.memberModel);
      yield MemberAddedState();
      this.add(FetchDataEvent());
    } else if (event is AddCourseEvent) {
      _courseService.save(event.courseModel);
      yield CourseAddedState();
      this.add(FetchDataEvent());
    } else if (event is AddStatusEvent) {
      _statusService.save(event.statusModel);
      yield StatusAddedState();
      this.add(FetchDataEvent());
    } else if (event is DeleteMemberEvent) {
      _memberService.deleteById(event.id);
      yield MemberDeletedState();
      this.add(FetchDataEvent());
    } else if (event is DeleteCourseEvent) {
      _courseService.deleteById(event.id);
      yield CourseDeletedState();
      this.add(FetchDataEvent());
    } else if (event is DeleteStatusEvent) {
      _statusService.deleteById(event.id);
      yield StatusDeletedState();
      this.add(FetchDataEvent());
    }
  }
}
