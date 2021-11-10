import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/bloc/meeting/meeting_bloc.dart';
import 'package:rm_app/model/course_models.dart';
import 'package:rm_app/model/form_models.dart';

class _RootCourseDialogWidget extends InheritedWidget {
  _RootCourseDialogWidget({Key key, @required this.child})
      : super(key: key, child: child);

  final Widget child;
  int radioValue = 0;
  String datePicker = '';
  static _RootCourseDialogWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_RootCourseDialogWidget>();
  }

  @override
  bool updateShouldNotify(_RootCourseDialogWidget oldWidget) {
    return true;
  }
}

class CourseDialog {
  static void dialogBuilder(BuildContext context) {
    BlocProvider.of<DataBloc>(context).add(FetchDataEvent());
    showDialog(
        context: context,
        builder: (ctxt) => _RootCourseDialogWidget(
              child: Dialog(
                backgroundColor: Colors.white,
                child: SafeArea(
                  child: BlocBuilder<DataBloc, DataState>(
                    builder: (context, state) {
                      if (state is DataLoadedState)
                        return Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Course',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                _CourseSelector(
                                  courseList: state.courseList,
                                ),
                                Text(
                                  'Date ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                _DatePicker(),
                                ButtonBar(
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('cancel'),
                                    ),
                                    BlocListener<MeetingBloc, MeetingState>(
                                      listener: (context, state) {
                                        if (state is MeetingAddedState)
                                          Navigator.popAndPushNamed(
                                              context, '/DetailsScreen',
                                              arguments: state.formModel);
                                      },
                                      child: TextButton(
                                        onPressed: () {
                                          BlocProvider.of<MeetingBloc>(context)
                                              .add(
                                            AddMeetingEvent(
                                              formModel: FormModel(
                                                course: CourseModel(
                                                    courseName: state.courseList
                                                        .where((element) =>
                                                            element.id ==
                                                            _RootCourseDialogWidget
                                                                    .of(context)
                                                                .radioValue)
                                                        .first
                                                        .courseName,
                                                    id: _RootCourseDialogWidget
                                                            .of(context)
                                                        .radioValue),
                                                date:
                                                    _RootCourseDialogWidget.of(
                                                            context)
                                                        .datePicker,
                                                members:
                                                    List.empty(growable: true),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text('add'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      else
                        return Center(
                          child: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () => BlocProvider.of<DataBloc>(context)
                                .add(FetchDataEvent()),
                          ),
                        );
                    },
                  ),
                ),
              ),
            ));
  }
}

class _CourseSelector extends StatefulWidget {
  _CourseSelector({Key key, this.courseList}) : super(key: key);
  List<CourseModel> courseList;
  @override
  _CourseSelectorState createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<_CourseSelector> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        children: [
          for (var course in widget.courseList)
            ListTile(
              title: Text('${course.courseName}'),
              leading: Radio(
                value: course.id,
                groupValue: _RootCourseDialogWidget.of(context).radioValue,
                onChanged: (value) {
                  setState(() {
                    _RootCourseDialogWidget.of(context).radioValue = value;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _DatePicker extends StatefulWidget {
  _DatePicker({Key key}) : super(key: key);

  @override
  __DatePickerState createState() => __DatePickerState();
}

class __DatePickerState extends State<_DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        DateTime selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        setState(() {
          _RootCourseDialogWidget.of(context).datePicker = '';
          _RootCourseDialogWidget.of(context).datePicker =
              '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}' ??
                  '';
          _RootCourseDialogWidget.of(context).datePicker =
              _RootCourseDialogWidget.of(context).datePicker == 'null-null-null'
                  ? ''
                  : _RootCourseDialogWidget.of(context).datePicker;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range,
                color: Color.fromRGBO(126, 87, 194, 1),
              ),
              Text(' select course date'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${_RootCourseDialogWidget.of(context).datePicker}'),
          )
        ],
      ),
    );
  }
}
