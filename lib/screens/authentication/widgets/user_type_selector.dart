import 'package:flutter/material.dart';

class UserTypeSelector extends StatelessWidget {
  final int groupValue;
  final int value;
  final Function(int?) onChanged;
  final String title;
  const UserTypeSelector({
    Key? key,
    required this.groupValue,
    required this.onChanged,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('$title'),
        leading: Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
