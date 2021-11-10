import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/home/home_bloc.dart';
import 'package:rm_app/bloc/meeting/meeting_bloc.dart';
import 'package:rm_app/model/form_models.dart';

class CourseCard extends StatelessWidget {
  CourseCard({Key key, @required this.formModel}) : super(key: key);

  ScrollController scrollController = ScrollController();
  FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _FormOptions.builder(context, formModel: formModel);
        // ** awesome code to show modal bottom sheet with resizable height **
        // showModalBottomSheet(
        //   backgroundColor: Colors.transparent,
        //   context: context,
        //   isScrollControlled: true,
        //   isDismissible: true,
        //   builder: (BuildContext context) {
        //     return DraggableScrollableSheet(
        //       initialChildSize: 0.75, //set this as you want
        //       maxChildSize: 0.95, //set this as you want
        //       minChildSize: 0.5, //set this as you want
        //       expand: true,
        //       builder: (context, scrollController) {
        //         return Scaffold(
        //           body: ListView.builder(
        //             controller: scrollController,
        //             itemCount: 100,
        //             itemBuilder: (context, indext) => Card(
        //               child: ListTile(
        //                 title: Text('data $indext'),
        //               ),
        //             ),
        //           ),
        //         ); //whatever you're returning, does not have to be a Container
        //       },
        //     );
        //   },
        // );
      },
      onTap: () {
        Navigator.of(context).pushNamed('/DetailsScreen', arguments: formModel);
      },
      child: Card(
        borderOnForeground: true,
        child: Container(
          height: 100,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${formModel.course.courseName}'),
                  Text('${formModel.date}'),
                ],
              ),
              Padding(padding: EdgeInsets.all(8)),
              Text('Members count : ${formModel.members.length}')
            ],
          ),
        ),
      ),
    );
  }
}

class _FormOptions {
  static void builder(BuildContext context, {FormModel formModel}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed('/DetailsScreen', arguments: formModel);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: Text(
                    'View Form',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _InfoDelete.builder(context, formModel.id);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: Text(
                    'Delete Form',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoDelete {
  static void builder(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocListener<MeetingBloc, MeetingState>(
          listener: (context, state) {
            if (state is MeetingDeletedState) Navigator.pop(context);
          },
          child: Dialog(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delete this Form ?',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<MeetingBloc>(context).add(
                              DeleteMeetingEvent(id: id),
                            );
                            BlocProvider.of<HomeBloc>(context).add(
                              FetchCourseDetails(),
                            );
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('No'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
