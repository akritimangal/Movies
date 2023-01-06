import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  late String _emailAddress;
  late String _password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("SIGN UP",
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
                    Image.asset("assets/images/signuplogo.png",
                        fit: BoxFit.cover, height: 170.0, width: 400.0),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //---------USERNAME FIELD-----------------------
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: 'Username',
                    //     labelStyle: TextStyle(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 20.0),
                    //     hintText: "Please enter your username",
                    //     icon: Icon(Icons.account_circle),
                    //     iconColor: Colors.green[900],
                    //   ),
                    //   validator: (value) {
                    //     if (value == null) {
                    //       return 'Please enter your username';
                    //     }
                    //     return null;
                    //   },
                    // ),


                    //---------------------------------------------------------------
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        hintText: "Please enter your email id",
                        icon: const Icon(Icons.email_outlined),
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
                      onSaved: (value) => _emailAddress = value!,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        icon: const Icon(Icons.password),
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
                      onSaved: (value) => _password = value!,
                    ),



                    ElevatedButton(
                      onPressed:() async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _emailAddress,
                              password: _password,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            }
                            else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                            }
                          }catch (e) {
                            print(e);
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
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    )

                    // Material(
                    //   color: Colors.green[900],
                    //   borderRadius:
                    //       BorderRadius.circular(changeButton ? 50 : 8),
                    //   child: InkWell(
                    //     //used to is to get button like features on container instead of justdetector..
                    //     onTap: () async {
                    //       if (_formKey.currentState!.validate()) {
                    //         _formKey.currentState!.save();
                    //         try {
                    //           final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //             email: emailAddress,
                    //             password: password,
                    //           );
                    //         } on FirebaseAuthException catch (e) {
                    //           if (e.code == 'weak-password') {
                    //             print('The password provided is too weak.');
                    //           }
                    //           else if (e.code == 'email-already-in-use') {
                    //             print('The account already exists for that email.');
                    //           }
                    //         }catch (e) {
                    //           print(e);
                    //         }
                    //       }
                    //
                    //     },
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
                    //               "SIGN UP",
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 17),
                    //             ),
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () => SignUpScreen(),
                    //   child: Text(
                    //     "First time here? Sign Up",
                    //     style: TextStyle(
                    //       color: Colors.green[900],
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 20.0,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
