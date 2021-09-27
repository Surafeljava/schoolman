import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schoolman/providers/providers.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthenticationProvider authenticationProvider = AuthenticationProvider();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogIn"),
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "example@abc.com",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "abc123",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Password cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                child: Text("LOGIN"),
                onPressed: () async {
                  //Signin here
                  if (_formKey.currentState!.validate()) {
                    await authenticationProvider.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
