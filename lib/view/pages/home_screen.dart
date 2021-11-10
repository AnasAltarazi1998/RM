import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/home/home_bloc.dart';
import 'package:rm_app/service/form_service.dart';
import 'package:rm_app/service/report_service.dart';
import 'package:rm_app/view/widgets/bottom_bar.dart';
import 'package:rm_app/view/widgets/course_card.dart';
import 'package:rm_app/view/widgets/course_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(FetchCourseDetails());
    return Scaffold(
      appBar: AppBar(
        title: Text('RM'),
        actions: [
          IconButton(
            onPressed: () => BlocProvider.of<HomeBloc>(context).add(
              FetchCourseDetails(),
            ),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
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
          else if (state is CourseDetailsLoadedState)
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: state.formsModel.length,
                itemBuilder: (context, index) => CourseCard(
                  formModel: state.formsModel[index],
                ),
              ),
            );
          else
            return Center(
              child: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(FetchCourseDetails());
                },
              ),
            );
        },
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CourseDialog.dialogBuilder(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
