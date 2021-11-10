import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/view/widgets/courses_info.dart';
import 'package:rm_app/view/widgets/members_info.dart';
import 'package:rm_app/view/widgets/status_info.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DataBloc>(context).add(FetchDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if (state is LoadingDataState)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            else if (state is DataLoadedState)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MembersInfo(
                      memberList: state.membersList,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: StatusInfo(
                      statusList: state.statusList,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: CoursesInfo(
                      courseList: state.courseList,
                    ),
                    flex: 1,
                  )
                ],
              );
            else
              return Center(
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () =>
                      BlocProvider.of<DataBloc>(context).add(FetchDataEvent()),
                ),
              );
          },
        ),
      ),
    );
  }
}
