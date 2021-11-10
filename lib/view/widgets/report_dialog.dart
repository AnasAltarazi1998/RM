import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/home/home_bloc.dart';
import 'package:rm_app/bloc/report/report_bloc.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/view/widgets/course_card.dart';

class _RootReportDialogWidget extends InheritedWidget {
  _RootReportDialogWidget({Key key, @required this.child})
      : super(key: key, child: child);

  final Widget child;
  List<bool> checks = List.empty(growable: true);
  List<FormModel> forms = List.empty(growable: true);
  static _RootReportDialogWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_RootReportDialogWidget>();
  }

  @override
  bool updateShouldNotify(_RootReportDialogWidget oldWidget) {
    return true;
  }
}

class ReportDialog {
  static void builder(BuildContext context) {
    // BlocProvider.of<HomeBloc>(context).add(FetchCourseDetails());
    showDialog(
      context: context,
      builder: (ctxt) => _RootReportDialogWidget(
        child: BlocListener<ReportBloc, ReportState>(
          listener: (context, state) {
            if (state is ReportGeneratedState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    height: 25,
                    alignment: Alignment.centerLeft,
                    child: Text('your report copied to clipboard'),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is LoadingCoursesDetailsState)
                      return Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    else if (state is CourseDetailsLoadedState) {
                      _RootReportDialogWidget.of(context).checks =
                          List.filled(state.formsModel.length, false);
                      _RootReportDialogWidget.of(context).forms =
                          state.formsModel;
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Generate Report : ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _CourseSelector(
                                forms: state.formsModel,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            child: ButtonBar(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (_RootReportDialogWidget.of(context)
                                            .checks
                                            .where((element) => element)
                                            .length >
                                        0) {
                                      List<FormModel> selectedForms =
                                          List.empty(growable: true);

                                      for (int i = 0;
                                          i <
                                              _RootReportDialogWidget.of(
                                                      context)
                                                  .checks
                                                  .length;
                                          i++)
                                        if (_RootReportDialogWidget.of(context)
                                            .checks[i])
                                          selectedForms.add(
                                              _RootReportDialogWidget.of(
                                                      context)
                                                  .forms[i]);
                                      BlocProvider.of<ReportBloc>(context).add(
                                        GenerateReportEvent(
                                            forms: selectedForms),
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            height: 25,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                'select a course to generate its report'),
                                          ),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Generarte'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else
                      return Center(
                        child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(FetchCourseDetails());
                          },
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseSelector extends StatefulWidget {
  _CourseSelector({Key key, this.forms}) : super(key: key);
  List<FormModel> forms = List.empty(growable: true);
  @override
  _CourseSelectorState createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<_CourseSelector> {
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.forms.length,
      itemBuilder: (context, index) => ListTile(
        title: Row(
          children: [
            Text('${widget.forms[index].course.courseName}'),
            Spacer(),
            Text('${widget.forms[index].date}'),
          ],
        ),
        leading: Checkbox(
          value: _RootReportDialogWidget.of(context).checks[index],
          onChanged: (value) {
            setState(() {
              _RootReportDialogWidget.of(context).checks[index] =
                  !_RootReportDialogWidget.of(context).checks[index];
            });
          },
        ),
      ),
    );
  }
}
