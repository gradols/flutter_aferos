import 'package:flutter/material.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/screens/utils/colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      theme: 
      ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
