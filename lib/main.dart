import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/bloc/details/details_bloc.dart';
import 'package:rm_app/bloc/home/home_bloc.dart';
import 'package:rm_app/bloc/meeting/meeting_bloc.dart';
import 'package:rm_app/bloc/report/report_bloc.dart';
import 'package:rm_app/init/init_app.dart';
import 'package:rm_app/service/form_service.dart';
import 'package:rm_app/service/report_service.dart';
import 'package:rm_app/theme/light_theme.dart';
import 'package:rm_app/view/pages/details_screen.dart';
import 'package:rm_app/view/pages/home_screen.dart';
import 'package:rm_app/view/pages/info_screen.dart';
import 'package:rm_app/view/pages/settings_screen.dart';
import 'package:rm_app/view/pages/splash_screen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => DetailsBloc(),
        ),
        BlocProvider(
          create: (context) => MeetingBloc(),
        ),
        BlocProvider(
          create: (context) => DataBloc(),
        ),
        BlocProvider(
          create: (context) => ReportBloc(),
        ),
      ],
      child: MaterialApp(
        home: InitApp(),
        theme: LightTheme.initTheme(),
        routes: {
          '/DetailsScreen': (_) => DetailsScreen(),
          '/InfoScreen': (_) => InfoScreen(),
          '/SettingsScreen': (_) => SettingsScreen(),
        },
      ),
    );
  }
}
