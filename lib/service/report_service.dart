import 'package:flutter/services.dart';
import 'package:rm_app/model/form_models.dart';

class ReportService {
  String _generateHeader(FormModel formModel) =>
      '\nحضور دورة #${formModel.course.courseName} بتاريخ ${formModel.date}';

  String _createReportForMeeting(FormModel formModel) {
    String membersWithStatus = '';

    for (var member in formModel.members) {
      membersWithStatus += '${member.name}      ${member.statusModel.status}\n';
    }
    String res = '$membersWithStatus';
    // Clipboard.setData(ClipboardData(text: res));
    return res;
  }

  String generateReportForListOfMeetings(List<FormModel> forms) {
    String res = '';
    for (var form in forms) {
      String header = _generateHeader(form);
      String body = _createReportForMeeting(form);
      res += '$header\n$body\n';
    }
    Clipboard.setData(ClipboardData(text: 'السلام عليكم استاذي\n$res'));

    return 'السلام عليكم استاذي\n$res';
  }
}
