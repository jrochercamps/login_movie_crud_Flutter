import 'package:flutter/material.dart';
import 'package:untitled/services/firebase_service.dart';
import 'package:untitled/screens/login_screen.dart';

Future<void> main() async {
  await initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
