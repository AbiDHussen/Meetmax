import 'package:flutter/material.dart';
import 'package:meetmax/screens/forgot_password_screen.dart';
import 'package:meetmax/screens/signup_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MeetmaxApp());
}

class MeetmaxApp extends StatelessWidget {
  const MeetmaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetmax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const ForgotPasswordScreen(),
    );
  }
}
