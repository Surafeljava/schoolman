import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:schoolman/models/models.dart';

class DatabaseProvider extends ChangeNotifier {
  final firestoreInstance = FirebaseFirestore.instance;

  bool registrationLoading = false;
  bool registered = false;
  bool registerChecked = false;

  StudentModel? student;
  TeacherModel? teacher;
  ParentModel? parent;
  RegistrarModel? registrar;

  List<StudentModel> studentsList = [];
  List<ClassModel> classesList = [];

  Future<void> registerUser(var userModel) async {
    setRegistrationLoading(true);
    try {
      await firestoreInstance.collection("users").add(userModel.toMap());
      registerChecked = true;
      registered = true;
      notifyListeners();
    } catch (e) {
      print("*** Failed to register user! ***");
    }
    setRegistrationLoading(false);
  }

  Future<void> getStudents() async {
    studentsList = [];
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection("users").get();
    querySnapshot.docs.forEach((element) {
      studentsList.add(StudentModel.fromJson(element.data().toString()));
    });
    notifyListeners();
  }

  Future<void> getClasses() async {
    classesList = [];
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection("classes").get();
    querySnapshot.docs.forEach((element) {
      classesList.add(ClassModel.fromJson(element.data().toString()));
    });
    notifyListeners();
  }

  Future<int> checkIfUserRegistered(String uid) async {
    //Check here
    var firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      firestoreInstance
          .collection("users")
          .doc(firebaseUser!.uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          if (value.data()!["userType"] == 0) {
            student = StudentModel.fromJson(value.data().toString());
          } else if (value.data()!["userType"] == 1) {
            teacher = TeacherModel.fromJson(value.data().toString());
          } else if (value.data()!["userType"] == 2) {
            parent = ParentModel.fromJson(value.data().toString());
          } else {
            registrar = RegistrarModel.fromJson(value.data().toString());
          }
          registered = true;
          registerChecked = true;
          notifyListeners();
          return value.data()!["userType"];
        }
      });
    } catch (e) {
      print("*** Error: $e");
    }
    return -1;
  }

  void setRegistrationLoading(bool val) {
    registrationLoading = val;
    notifyListeners();
  }
}
