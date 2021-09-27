import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolman/models/models.dart';
import 'package:schoolman/providers/providers.dart';

class ClassSelector extends StatefulWidget {
  final Function(String) onClassSelected;
  const ClassSelector({
    Key? key,
    required this.onClassSelected,
  }) : super(key: key);

  @override
  _ClassSelectorState createState() => _ClassSelectorState();
}

class _ClassSelectorState extends State<ClassSelector> {
  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseProvider>(context, listen: false).getClasses();
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
              Text("No Classes"),
              SizedBox(height: 10,),
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
            ClassModel classModel = databaseProvider.classesList[index];
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 50,
                child: ListTile(
                  title: Text(
                    "${classModel.className}",
                  ),
                  subtitle: Text("${classModel.subjects}"),
                  onTap: () {
                    widget.onClassSelected(classModel.className);
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
