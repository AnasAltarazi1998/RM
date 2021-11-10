import 'package:flutter/material.dart';
import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/model/member_models.dart';
import 'package:rm_app/model/status_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetDialog {
  static void builder(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctxt) => AlertDialog(
        title: Text('Reset App'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () async {
              SharedPreferences sharedPreference =
                  await SharedPreferences.getInstance();
              sharedPreference.setString('init', '{"status": "done"}');
              sharedPreference.clear();
              if (sharedPreference.getString('courses') == null)
                sharedPreference.setString(
                    'courses', CoursesModel().toJson().toString());
              if (sharedPreference.getString('members') == null)
                sharedPreference.setString(
                    'members', MembersModel().toJson().toString());
              if (sharedPreference.getString('forms') == null)
                sharedPreference.setString(
                    'forms', FormsModel().toJson().toString());
              if (sharedPreference.getString('statuses') == null)
                sharedPreference.setString(
                    'statuses', StatusesModel().toJson().toString());
              !sharedPreference.containsKey('UUID')
                  ? sharedPreference.setInt('UUID', 0)
                  : sharedPreference.getInt('UUID');
              Navigator.pop(context);
            },
            child: Text(
              'ok',
            ),
          ),
        ],
      ),
    );
  }
}
