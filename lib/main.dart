import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_recommendation/screens/auth_gate.dart';
import 'package:recipe_recommendation/screens/home_screen.dart';
import 'package:recipe_recommendation/screens/profile_screen.dart';
import 'package:recipe_recommendation/screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/signup': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: AuthGate(),
    );
  }
}