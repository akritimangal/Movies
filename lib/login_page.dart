import 'package:flutter/material.dart';
import 'package:movies_app/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberme = false;
  bool changeButton = false;
  late String _emailAddress;
  late String _password;

  moveTohome(BuildContext context) async {
    //async to be entered when we are having awaitng things
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
        //bool value changes.
      });
      await Future.delayed(Duration(seconds: 2));
      //wait for 2 seconds before implementing below changes
      await Navigator.pushNamed(context, "\home");
      //direct to homepage
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("LOG IN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0)),
          backgroundColor: Colors.green[900],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/loginlogo.png",
                        fit: BoxFit.cover, height: 170.0, width: 400.0),
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        hintText: "Please enter your email id",
                        icon: Icon(Icons.email_outlined),
                        iconColor: Colors.green[900],
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter your email';
                        } else if (!(value.contains("@"))) {
                          return "Email id must contain @";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        icon: Icon(Icons.password),
                        iconColor: Colors.green[900],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "password's length must be greater than 6";
                        }

                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _rememberme,
                            activeColor: Colors.green[900],
                            onChanged: (value) {
                              setState(() {
                                _rememberme = value!;
                              });
                            },
                          ),
                          Text('Remember me',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailAddress, password: _password);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                            moveTohome(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                        elevation: 15.0,
                      ),
                      child: AnimatedContainer(
                        //animated container to implement animation instead of simple container
                        duration: Duration(seconds: 2),
                        height: 40,
                        width: changeButton ? 50 : 120,
                        //if changeButton true then make width 50 else 150
                        alignment: Alignment.center,
                        // ignore: sort_child_properties_last
                        child: changeButton
                            ? Icon(Icons.done, color: Colors.white)
                            //if changeButton true then show done icon else text
                            : Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                      ),
                    ),

                    //------------------------------------------------------------------
                    // Material(
                    //   color: Colors.green[900],
                    //   borderRadius:
                    //       BorderRadius.circular(changeButton ? 50 : 8),
                    //   child: InkWell(
                    //     //used to is to get button like features on container instead of justdetector..
                    //     onTap: () => moveTohome(context),
                    //     child: AnimatedContainer(
                    //       //animated container to implement animation instead of simple container
                    //       duration: Duration(seconds: 2),
                    //       height: 40,
                    //       width: changeButton ? 50 : 120,
                    //       //if changeButton true then make width 50 else 150
                    //       alignment: Alignment.center,
                    //       // ignore: sort_child_properties_last
                    //       child: changeButton
                    //           ? Icon(Icons.done, color: Colors.white)
                    //           //if changeButton true then show done icon else text
                    //           : Text(
                    //               "Login",
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 17),
                    //             ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () => SignUpScreen(),
                      child: Text(
                        "First time here? Sign Up",
                        style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
