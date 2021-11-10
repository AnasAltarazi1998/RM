import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/service/report_service.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial());
  ReportService reportService = ReportService();
  @override
  Stream<ReportState> mapEventToState(
    ReportEvent event,
  ) async* {
    if (event is GenerateReportEvent) {
      reportService.generateReportForListOfMeetings(event.forms);
      yield ReportGeneratedState();
    }
  }
}
