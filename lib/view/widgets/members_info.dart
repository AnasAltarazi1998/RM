import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/model/member_models.dart';

class MembersInfo extends StatelessWidget {
  MembersInfo({Key key, this.memberList}) : super(key: key);
  List<MemberModel> memberList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Members',
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
                    Text('${memberList[index].name}'),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          _InfoDelete.builder(context, memberList[index].id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red, size: 20))
                  ],
                ),
              ),
            ),
            itemCount: memberList.length,
          ),
        ),
        _AddMember(),
      ],
    );
  }
}

class _AddMember extends StatelessWidget {
  const _AddMember({Key key}) : super(key: key);

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
            'Add new member',
            style: TextStyle(
                color: Color.fromRGBO(126, 87, 194, 1),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _InfoInput {
  static void builder(BuildContext context) {
    TextEditingController memberNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => BlocListener<DataBloc, DataState>(
        listener: (context, state) {
          if (state is MemberAddedState) Navigator.pop(context);
        },
        child: Dialog(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: memberNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Member Name',
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
                        if (memberNameController.text.length > 0)
                          BlocProvider.of<DataBloc>(context).add(
                            AddMemberEvent(
                              memberModel:
                                  MemberModel(name: memberNameController.text),
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
            if (state is MemberDeletedState) Navigator.pop(context);
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
                      'Delete this member ?',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<DataBloc>(context).add(
                              DeleteMemberEvent(id: id),
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
