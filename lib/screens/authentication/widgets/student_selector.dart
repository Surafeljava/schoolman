import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolman/models/models.dart';
import 'package:schoolman/providers/providers.dart';

class StudentSelector extends StatefulWidget {
  final Function(String) onStudentSelected;
  const StudentSelector({
    Key? key,
    required this.onStudentSelected,
  }) : super(key: key);

  @override
  _StudentSelectorState createState() => _StudentSelectorState();
}

class _StudentSelectorState extends State<StudentSelector> {
  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseProvider>(context, listen: false).getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
        // stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, databaseProvider, snapshot) {
      if (databaseProvider.studentsList.isEmpty) {
        return Center(
          child: Column(
            children: [
              Text("No Students"),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: databaseProvider.studentsList.length,
          itemBuilder: (context, index) {
            StudentModel studentModel = databaseProvider.studentsList[index];
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 50,
                child: ListTile(
                  title: Text(
                    "${studentModel.name} ${studentModel.fatherName}",
                  ),
                  subtitle: Text("${studentModel.phone}"),
                  onTap: () {
                    widget.onStudentSelected(studentModel.uid);
                  },
                ),
              ),
            );
          },
        );
      }
    });
  }
}
