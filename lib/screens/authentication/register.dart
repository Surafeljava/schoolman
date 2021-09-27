import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolman/models/models.dart';
import 'package:schoolman/providers/providers.dart';
import 'package:schoolman/screens/authentication/widgets/widgets.dart';
import 'package:schoolman/screens/registrar/registrar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController grandFatherNameController = TextEditingController();
  DateTime bDate = DateTime.now();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController uniqueAddressController = TextEditingController();

  //USER 0-student 1-teacher 2-parent 3-registrar
  int groupValue = 0;

  String classSelected = "";
  String studentSelected = "";

  final _formKey = GlobalKey<FormState>();

  void onRadioChanged(int? value) {
    setState(() {
      groupValue = value!;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != bDate)
      setState(() {
        bDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Registration"),
              SizedBox(
                width: 5,
              ),
              if (databaseProvider.registrationLoading)
                Container(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                print("Logging out");
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                UserTypeSelector(
                  groupValue: groupValue,
                  onChanged: onRadioChanged,
                  value: 0,
                  title: "Student",
                ),
                UserTypeSelector(
                  groupValue: groupValue,
                  onChanged: onRadioChanged,
                  value: 1,
                  title: "Teacher",
                ),
                UserTypeSelector(
                  groupValue: groupValue,
                  onChanged: onRadioChanged,
                  value: 2,
                  title: "Parent",
                ),
                UserTypeSelector(
                  groupValue: groupValue,
                  onChanged: onRadioChanged,
                  value: 3,
                  title: "Registrar",
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "your name",
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: fatherNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Father Name",
                    hintText: "your father name",
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Father name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: grandFatherNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Grand Father Name",
                    hintText: "grand father name",
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Grand father name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("${bDate.day}/${bDate.month}/${bDate.year}"),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    hintText: "0911010203",
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Phone cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    labelText: "Address",
                    hintText: "your address",
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Address cannot be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                getLastField(
                  selectedUser: groupValue,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text("REGISTER"),
                  onPressed: () {
                    //Signin here
                    if (_formKey.currentState!.validate()) {
                      var firebaseUser = FirebaseAuth.instance.currentUser;
                      String uid = firebaseUser!.uid;
                      if (groupValue == 0) {
                        StudentModel student = StudentModel(
                          name: nameController.text,
                          fatherName: fatherNameController.text,
                          gFatherName: grandFatherNameController.text,
                          bDate: bDate.toIso8601String(),
                          phone: phoneController.text,
                          address: addressController.text,
                          classValue: classSelected,
                          uid: uid,
                          userType: groupValue,
                        );
                        databaseProvider.registerUser(student);
                      } else if (groupValue == 1) {
                        TeacherModel teacher = TeacherModel(
                          name: nameController.text,
                          fatherName: fatherNameController.text,
                          gFatherName: grandFatherNameController.text,
                          bDate: bDate.toIso8601String(),
                          phone: phoneController.text,
                          address: addressController.text,
                          classValue: classSelected,
                          uid: uid,
                          userType: groupValue,
                        );
                        databaseProvider.registerUser(teacher);
                      } else if (groupValue == 2) {
                        ParentModel parent = ParentModel(
                          name: nameController.text,
                          fatherName: fatherNameController.text,
                          gFatherName: grandFatherNameController.text,
                          bDate: bDate.toIso8601String(),
                          phone: phoneController.text,
                          address: addressController.text,
                          uid: uid,
                          userType: groupValue,
                          studentId: studentSelected,
                        );
                        databaseProvider.registerUser(parent);
                      } else {
                        RegistrarModel registrar = RegistrarModel(
                          name: nameController.text,
                          fatherName: fatherNameController.text,
                          gFatherName: grandFatherNameController.text,
                          bDate: bDate.toIso8601String(),
                          phone: phoneController.text,
                          address: addressController.text,
                          uid: uid,
                          userType: groupValue,
                        );
                        databaseProvider.registerUser(registrar);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getLastField({required int selectedUser}) {
    if (selectedUser == 0 || selectedUser == 1) {
      return ClassSelector(onClassSelected: onClassSelected);
    } else if (selectedUser == 2) {
      return StudentSelector(onStudentSelected: onStudentSelected);
    } else {
      return TextFormField(
        controller: uniqueAddressController,
        keyboardType: TextInputType.streetAddress,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Unique Address",
          hintText: "XXXXXX",
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "Unique address cannot be empty";
          } else {
            return null;
          }
        },
      );
    }
  }

  void onClassSelected(String selectedValue) {
    setState(() {
      classSelected = selectedValue;
    });
  }

  void onStudentSelected(String selectedValue) {
    setState(() {
      studentSelected = selectedValue;
    });
  }
}
