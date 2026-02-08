import 'package:flutter/material.dart';
import 'package:recipe_recommendation/services/auth_service.dart';
import 'package:recipe_recommendation/widgets/custom_hero_banner.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _authService.login(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );
      
    } catch(e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeroBanner(), // for header image + logo + app name
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sign in to discover amazing recipes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            // TODO: ADD EMAIL VALIDATION LATER
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'your.email@example.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'password..',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onLoginPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 255, 179, 125), Color.fromARGB(255, 200, 255, 112)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight
                      ),
                    ),
                    child: Text(
                      "🥗 Scan Ingredients • Get recipes • Cook delicious meals",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
