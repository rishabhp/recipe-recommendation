import 'package:flutter/material.dart';
import 'package:recipe_recommendation/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Welcome to our website! ${AuthService().currentUser!.email}")));
  }
}
