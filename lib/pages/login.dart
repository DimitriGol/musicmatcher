import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:songbird/widgets/form_container_widget.dart';


import '../firebase_auth/firebase_auth_class.dart';
import 'signup.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,//PAGE COLOR
        body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'lib/images/songbird_black_logo_and_text.png',
                  width: 280, // Adjust width according to your preference
                  height: 120, // Adjust height according to your preference
                ),
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: _signIn,
                  child: Container(
                      width: 250,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.yellow,//LOGIN BUTTON COLOR
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Dont have an account?"),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        (route) => false,
                      );
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        )))
              ])
            ],
          ),
        ));
  }


  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;


    User? user = await _auth.signInWithEmailAndPassword(email, password);


    if (user != null) {
      Navigator.pushNamed(context, "/home");
    } else {
      print("Some error happened, user is null");
    }
  }
}