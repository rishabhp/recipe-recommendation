import 'package:flutter/material.dart';

class CustomHeroBanner extends StatelessWidget {
  const CustomHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/hero-dark.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          bottom: 40,
          left: 40,
          child: Row(
            children: [
              Container(
                height: 64,
                width: 64,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(220),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(Icons.kitchen, color: Colors.orange),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ChefMate",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    "Your Smart Kitchen Assistant",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
