import 'package:flutter/material.dart';
import 'package:schoolman/screens/teacher/widgets/widgets.dart';

class Teacher extends StatefulWidget {
  const Teacher({Key? key}) : super(key: key);

  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StudentsList(),
    );
  }
}
