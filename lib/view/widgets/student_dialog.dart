import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rm_app/model/student_models.dart';

class _RootAddStudentDialogWidget extends InheritedWidget {
  _RootAddStudentDialogWidget({Key key, @required this.child})
      : super(key: key, child: child);

  final Widget child;
  List<StudentModel> StudentList;
  List<bool> checks = List.empty(growable: true);
  int val = 0;
  static _RootAddStudentDialogWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_RootAddStudentDialogWidget>();
  }

  @override
  bool updateShouldNotify(_RootAddStudentDialogWidget oldWidget) {
    return true;
  }
}

class StudentDialog {
  static void dialogBuiler(BuildContext context, int formId) {
    // BlocProvider.of<DataBloc>(context).add(FetchDataEvent());
    showDialog(
      context: context,
      builder: (ctxt) => _RootAddStudentDialogWidget(
        child: Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height * 85 / 100,
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StudentsList(),
                  _StudentInfoTile(),
                  _HomeWorkTile(),
                  _StudentNotesTile(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentNotesTile extends StatelessWidget {
  const _StudentNotesTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          'Student Notes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          StudentNotes(
            label: 'Notes',
          )
        ]);
  }
}

class _StudentInfoTile extends StatelessWidget {
  const _StudentInfoTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Student Info',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('papers / lines count : '),
              Container(
                color: Colors.white,
                height: 40,
                width: MediaQuery.of(context).size.width * 40 / 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Radio(value: 0, groupValue: 0, onChanged: (value) {}),
                Text('Compeleted'),
              ],
            ),
            Column(
              children: [
                Radio(value: 1, groupValue: 0, onChanged: (value) {}),
                Text('Prepared'),
              ],
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Radio(value: 0, groupValue: 0, onChanged: (value) {}),
                Text('Papers'),
              ],
            ),
            Column(
              children: [
                Radio(value: 1, groupValue: 0, onChanged: (value) {}),
                Text('lines'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeWorkTile extends StatelessWidget {
  const _HomeWorkTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Student Homework',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        StudentNotes(
          label: 'Homework',
        )
      ],
    );
  }
}

class StudentNotes extends StatelessWidget {
  final String label;
  StudentNotes({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        maxLines: 8,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentsList extends StatefulWidget {
  const _StudentsList({
    Key key,
  }) : super(key: key);

  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<_StudentsList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Select Student',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        ListTile(
          title: Text('ahmad'),
          leading: Radio(
            value: 0,
            groupValue: _RootAddStudentDialogWidget.of(context).val,
            onChanged: (value) {
              setState(() {
                _RootAddStudentDialogWidget.of(context).val = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text('ahmad'),
          leading: Radio(
            value: 1,
            groupValue: _RootAddStudentDialogWidget.of(context).val,
            onChanged: (value) {
              setState(() {
                _RootAddStudentDialogWidget.of(context).val = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
