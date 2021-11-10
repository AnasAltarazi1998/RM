import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/meeting/meeting_bloc.dart';
import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/view/widgets/bottom_bar.dart';
import 'package:rm_app/view/widgets/details_item.dart';
import 'package:rm_app/view/widgets/member_dialog.dart';
import 'package:rm_app/view/widgets/student_dialog.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FormModel formModel =
        ModalRoute.of(context).settings.arguments as FormModel;
    BlocProvider.of<MeetingBloc>(context)
        .add(FetchMeetingEvent(meetingId: formModel.id));
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.book),
            ),
            Tab(
              icon: Icon(Icons.book),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MembersTab(formModel: formModel),
          _StudentsTab(formModel: formModel),
        ],
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tabController.index == 0
              ? MemberDialog.dialogBuiler(context, formModel.id)
              : StudentDialog.dialogBuiler(context, formModel.id);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _MembersTab extends StatelessWidget {
  _MembersTab({
    Key key,
    @required this.formModel,
  }) : super(key: key);

  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(flex: 1),
                Text('${formModel.course.courseName}'),
                Spacer(flex: 4),
                Text('${formModel.date}'),
                Spacer(flex: 4),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: BlocBuilder<MeetingBloc, MeetingState>(
            builder: (context, state) {
              if (state is MeetingLoadedState)
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.formModel.members.length,
                    itemBuilder: (context, index) => DetailsItem(
                      memberWithStatusModel: state.formModel.members[index],
                      meetingId: state.formModel.id,
                    ),
                  ),
                );
              else if (state is MeetingLoadingState)
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              else
                return Center(
                  child: IconButton(
                    onPressed: () => BlocProvider.of<MeetingBloc>(context).add(
                      FetchMeetingEvent(meetingId: formModel.id),
                    ),
                    icon: Icon(Icons.refresh),
                  ),
                );
            },
          ),
        ),
      ],
    );
  }
}

class _StudentsTab extends StatelessWidget {
  _StudentsTab({
    Key key,
    @required this.formModel,
  }) : super(key: key);

  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(flex: 1),
                Text('${formModel.course.courseName}'),
                Spacer(flex: 4),
                Text('${formModel.date}'),
                Spacer(flex: 4),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: BlocBuilder<MeetingBloc, MeetingState>(
            builder: (context, state) {
              if (state is MeetingLoadedState)
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.formModel.members.length,
                    itemBuilder: (context, index) => DetailsItem(
                      memberWithStatusModel: state.formModel.members[index],
                      meetingId: state.formModel.id,
                    ),
                  ),
                );
              else if (state is MeetingLoadingState)
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              else
                return Center(
                  child: IconButton(
                    onPressed: () => BlocProvider.of<MeetingBloc>(context).add(
                      FetchMeetingEvent(meetingId: formModel.id),
                    ),
                    icon: Icon(Icons.refresh),
                  ),
                );
            },
          ),
        ),
      ],
    );
  }
}
