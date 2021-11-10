import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/bloc/details/details_bloc.dart';
import 'package:rm_app/bloc/home/home_bloc.dart';
import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/model/member_models.dart';
import 'package:rm_app/model/status_models.dart';
import 'package:rm_app/service/form_service.dart';
import 'package:rm_app/service/report_service.dart';
import 'package:rm_app/view/pages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitApp extends StatelessWidget {
  Future<Widget> init() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('init', '{"status": "done"}');
    // sharedPreference.clear();
    // sharedPreference.setString('members', MembersModel().toJson().toString());
    if (sharedPreference.getString('courses') == null)
      sharedPreference.setString('courses', CoursesModel().toJson().toString());
    if (sharedPreference.getString('members') == null)
      sharedPreference.setString('members', MembersModel().toJson().toString());
    if (sharedPreference.getString('forms') == null)
      sharedPreference.setString('forms', FormsModel().toJson().toString());
    if (sharedPreference.getString('statuses') == null)
      sharedPreference.setString(
          'statuses', StatusesModel().toJson().toString());

    return Future.value(HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      durationInSeconds: 3,
      logo: Image.asset('assets/images/rm.jpg'),
      title: Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      futureNavigator: init(),
    );
  }
}
