import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/home/home_bloc.dart';
import 'package:rm_app/view/widgets/report_dialog.dart';
import 'package:rm_app/view/widgets/reset_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(FetchCourseDetails());

                ReportDialog.builder(context);
              },
              child: Text('Generate Report'),
            ),
            ElevatedButton(
              onPressed: () {
                ResetDialog.builder(context);
              },
              child: Text('Reset App'),
            ),
          ],
        ),
      ),
    );
  }
}
