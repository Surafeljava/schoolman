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
      var firebaseUser = FirebaseAuth.instance.currentUser;
      String uid = firebaseUser!.uid;
      await firestoreInstance
          .collection("users")
          .doc(uid)
          .set(userModel.toMap());
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
      classesList
          .add(ClassModel.fromMap(element.data() as Map<String, dynamic>));
    });
    notifyListeners();
  }

  Future<int> checkIfUserRegistered(String uid) async {
    //Check here
    try {
      var value = await firestoreInstance.collection("users").doc(uid).get();
      if (value.data() != null) {
        if (value.data()!["userType"] == 0) {
          student = StudentModel.fromMap(value.data()!);
        } else if (value.data()!["userType"] == 1) {
          teacher = TeacherModel.fromMap(value.data()!);
        } else if (value.data()!["userType"] == 2) {
          parent = ParentModel.fromMap(value.data()!);
        } else {
          registrar = RegistrarModel.fromMap(value.data()!);
        }
        registered = true;
        registerChecked = true;
        notifyListeners();
        int type = value.data()!["userType"];
        return type;
      }
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
