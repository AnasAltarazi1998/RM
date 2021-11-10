part of 'report_bloc.dart';

@immutable
abstract class ReportEvent {}

class GenerateReportEvent extends ReportEvent {
  final List<FormModel> forms;
  GenerateReportEvent({this.forms});
}
