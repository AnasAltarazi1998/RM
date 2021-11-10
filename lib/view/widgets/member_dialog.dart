import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/bloc/meeting/meeting_bloc.dart';
import 'package:rm_app/model/member_models.dart';
import 'package:rm_app/model/member_with_status_models.dart';
import 'package:rm_app/model/status_models.dart';

class _RootAddMemberDialogWidget extends InheritedWidget {
  _RootAddMemberDialogWidget({Key key, @required this.child})
      : super(key: key, child: child);

  final Widget child;
  List<MemberModel> memberList;
  List<bool> checks = List.empty(growable: true);
  int val = 0;
  static _RootAddMemberDialogWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_RootAddMemberDialogWidget>();
  }

  @override
  bool updateShouldNotify(_RootAddMemberDialogWidget oldWidget) {
    return true;
  }
}

class MemberDialog {
  static void dialogBuiler(BuildContext context, int formId) {
    BlocProvider.of<DataBloc>(context).add(FetchDataEvent());
    showDialog(
      context: context,
      builder: (ctxt) => _RootAddMemberDialogWidget(
        child: Dialog(
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataLoadedState) {
                _RootAddMemberDialogWidget.of(context).memberList =
                    state.membersList;
                _RootAddMemberDialogWidget.of(context).checks =
                    List.filled(state.membersList.length, false);
                return Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'select Member',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _MembersList(),
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'select status',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: _StatusList(
                          statusList: state.statusList,
                        ),
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('cancel'),
                          ),
                          BlocListener<MeetingBloc, MeetingState>(
                            listener: (context, state) {
                              if (state is MembersAddedToMeetingState)
                                Navigator.pop(context);
                            },
                            child: TextButton(
                              onPressed: () {
                                List<MemberWithStatusModel>
                                    memberWithStatusList =
                                    List.empty(growable: true);
                                for (int i = 0;
                                    i < state.membersList.length;
                                    i++) {
                                  if (_RootAddMemberDialogWidget.of(context)
                                      .checks[i])
                                    memberWithStatusList.add(
                                      MemberWithStatusModel(
                                        name: _RootAddMemberDialogWidget.of(
                                                context)
                                            .memberList[i]
                                            .name,
                                        statusModel: StatusModel(
                                            status: state.statusList
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    _RootAddMemberDialogWidget
                                                            .of(context)
                                                        .val)
                                                .status),
                                      ),
                                    );
                                }
                                BlocProvider.of<MeetingBloc>(context).add(
                                    AddMembersToMeetingEvent(
                                        formId: formId,
                                        memberWithStatusList:
                                            memberWithStatusList));
                              },
                              child: Text('add'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is LoadingDataState)
                return Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              else
                return Center(
                  child: IconButton(
                    onPressed: () => BlocProvider.of<DataBloc>(context).add(
                      FetchDataEvent(),
                    ),
                    icon: Icon(Icons.refresh),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}

class _MembersList extends StatefulWidget {
  _MembersList({Key key}) : super(key: key);

  @override
  __MembersListState createState() => __MembersListState();
}

class __MembersListState extends State<_MembersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _RootAddMemberDialogWidget.of(context).checks.length,
      itemBuilder: (context, index) => Row(
        children: [
          Checkbox(
            value: _RootAddMemberDialogWidget.of(context).checks[index],
            onChanged: (value) {
              setState(() {
                _RootAddMemberDialogWidget.of(context).checks[index] =
                    !_RootAddMemberDialogWidget.of(context).checks[index];
              });
            },
          ),
          Text(
              '${_RootAddMemberDialogWidget.of(context).memberList[index].name}'),
        ],
      ),
    );
  }
}

class _StatusList extends StatefulWidget {
  _StatusList({Key key, @required this.statusList}) : super(key: key);
  List<StatusModel> statusList;
  @override
  __StatusListState createState() => __StatusListState();
}

class __StatusListState extends State<_StatusList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var item in widget.statusList)
            ListTile(
              title: Text('${item.status}'),
              leading: Radio(
                value: item.id,
                groupValue: _RootAddMemberDialogWidget.of(context).val,
                onChanged: (value) {
                  setState(() {
                    _RootAddMemberDialogWidget.of(context).val = value;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
