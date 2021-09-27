import 'package:flutter/material.dart';
import 'package:schoolman/screens/parent/widgets/widgets.dart';

class Parent extends StatefulWidget {
  const Parent({Key? key}) : super(key: key);

  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StudentGradeView(),
    );
  }
}
