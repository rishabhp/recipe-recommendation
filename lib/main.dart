import 'package:flutter/material.dart';
import 'package:recipe_recommendation/screens/registration_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Recommender',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => RegistrationScreen() 
      },
      home: LoginScreen(),
    );
  }
}