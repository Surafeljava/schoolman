import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolman/providers/providers.dart';
import 'package:schoolman/screens/screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, snapshot) {
      //Check If Authenticated
      //If True
      //Go to the specific user page
      //If False
      //Go to the Authentication Page
      final firebaseUser = Provider.of<User?>(context);
      if (firebaseUser == null) {
        //Get the user data and lead to the respective user
        return Login();
      } else {
        if (!databaseProvider.registerChecked) {
          return Scaffold(
            body: Center(
              child: Text("Checking..."),
            ),
          );
        } else {
          //Check if registered
          var firebaseUser = FirebaseAuth.instance.currentUser;
          databaseProvider
              .checkIfUserRegistered(firebaseUser!.uid)
              .then((value) async {
            if (!databaseProvider.registered) {
              //Go to register
              return Register();
            } else {
              //Go to home

              print("**** Val: $value");
              print("**** Registered: ${databaseProvider.registered}");
              if (value == 0) {
                return Student();
              } else if (value == 1) {
                return Teacher();
              } else if (value == 2) {
                return Parent();
              } else {
                return Registrar();
              }
            }
          });
        }
      }
      return Register();
    });
  }
}
