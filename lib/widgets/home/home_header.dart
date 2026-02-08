import 'package:flutter/material.dart';
import 'package:recipe_recommendation/utils/app_gradients.dart';

class HomeHeader extends StatelessWidget {
  final String username;
  const HomeHeader({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $username! 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "What shall we cook today?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Favourite Recipe Card
              Center(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: const [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "12",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Favourite Recipes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
