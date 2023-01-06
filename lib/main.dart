import 'package:flutter/material.dart';
import 'package:movies_app/home_page.dart';
import 'package:movies_app/login_page.dart';
import 'package:movies_app/signup_page.dart';
import 'package:movies_app/widgets/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

// void main(){
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      // initialRoute: MyRoutes.homeRoute,
      routes: {
        "/": (context) => LoginScreen(),
        "/home":(context) =>HomeScreen(),
        "/signup": (context) => SignUpScreen(),
        "/login": (context) => LoginScreen(),


      },
    );
  }
}
