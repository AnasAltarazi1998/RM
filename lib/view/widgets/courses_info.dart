import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/model/course_models.dart';

class CoursesInfo extends StatelessWidget {
  CoursesInfo({Key key, this.courseList}) : super(key: key);
  List<CourseModel> courseList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Courses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Expanded(
          flex: 3,
          child: ListView.builder(
            itemBuilder: (context, index) => Card(
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('${courseList[index].courseName}'),
                    Spacer(),
                    IconButton(
                        onPressed: () =>
                            _InfoDelete.builder(context, courseList[index].id),
                        icon: Icon(Icons.delete, color: Colors.red, size: 20))
                  ],
                ),
              ),
            ),
            itemCount: courseList.length,
          ),
        ),
        _AddCourses(),
      ],
    );
  }
}

class _AddCourses extends StatelessWidget {
  const _AddCourses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          _InfoInput.builder(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.add,
              color: Color.fromRGBO(126, 87, 194, 1),
            ),
            Text(
              'Add new Courses',
              style: TextStyle(
                  color: Color.fromRGBO(126, 87, 194, 1),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}

class _InfoInput {
  static void builder(BuildContext context) {
    TextEditingController courseNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Form(
          child: BlocListener<DataBloc, DataState>(
            listener: (context, state) {
              if (state is CourseAddedState) Navigator.pop(context);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: courseNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Course Name',
                    ),
                  ),
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (courseNameController.text.length > 0)
                          BlocProvider.of<DataBloc>(context).add(
                            AddCourseEvent(
                              courseModel: CourseModel(
                                  courseName: courseNameController.text),
                            ),
                          );
                      },
                      child: Text('add'),
                    ),
                  ],
                )
              ],
            ),
          ),
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
        return BlocListener<DataBloc, DataState>(
          listener: (context, state) {
            if (state is CourseDeletedState) Navigator.pop(context);
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
                      'Delete this course ?',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<DataBloc>(context).add(
                              DeleteCourseEvent(id: id),
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
