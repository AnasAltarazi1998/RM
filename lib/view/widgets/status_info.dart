import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_app/bloc/data/data_bloc.dart';
import 'package:rm_app/model/status_models.dart';

class StatusInfo extends StatelessWidget {
  StatusInfo({Key key, this.statusList}) : super(key: key);
  List<StatusModel> statusList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
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
                    Text('${statusList[index].status}'),
                    Spacer(),
                    IconButton(
                      onPressed: () =>
                          _InfoDelete.builder(context, statusList[index].id),
                      icon: Icon(Icons.delete, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: statusList.length,
          ),
        ),
        _AddStatus(),
      ],
    );
  }
}

class _AddStatus extends StatelessWidget {
  const _AddStatus({Key key}) : super(key: key);

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
              'Add new Status',
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
    TextEditingController statusValueController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Form(
          child: BlocListener<DataBloc, DataState>(
            listener: (context, state) {
              if (state is StatusAddedState) Navigator.pop(context);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: statusValueController,
                    decoration: InputDecoration(
                      hintText: 'Enter Status Name',
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
                        if (statusValueController.text.length > 0)
                          BlocProvider.of<DataBloc>(context).add(
                            AddStatusEvent(
                              statusModel: StatusModel(
                                  status: statusValueController.text),
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
            if (state is StatusDeletedState) Navigator.pop(context);
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
                      'Delete this Status ?',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<DataBloc>(context).add(
                              DeleteStatusEvent(id: id),
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
