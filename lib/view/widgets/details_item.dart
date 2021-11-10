import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/meeting/meeting_bloc.dart';
import 'package:rm_app/model/member_with_status_models.dart';

class DetailsItem extends StatelessWidget {
  DetailsItem(
      {Key key, @required this.memberWithStatusModel, @required this.meetingId})
      : super(key: key);
  MemberWithStatusModel memberWithStatusModel;
  int meetingId;
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(flex: 1),
            Text('${memberWithStatusModel.name}'),
            Spacer(flex: 5),
            Text('${memberWithStatusModel.statusModel.status}'),
            Spacer(flex: 5),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                _DeleteMemberDialog.builder(
                    context, meetingId, memberWithStatusModel.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _DeleteMemberDialog {
  static void builder(BuildContext context, int meetingId, int memberId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocListener<MeetingBloc, MeetingState>(
            listener: (context, state) {
              if (state is MemberDeletedFromMeetingState) {
                print('access listen');
                Navigator.pop(context);
              }
            },
            child: Dialog(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Delete Memebr ?'),
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
                            BlocProvider.of<MeetingBloc>(context).add(
                              DeleteMemberFromMeetingEvent(
                                  meetingId: meetingId, memberId: memberId),
                            );
                          },
                          child: Text('ok'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
