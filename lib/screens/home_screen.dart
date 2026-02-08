import 'package:flutter/material.dart';
import 'package:recipe_recommendation/services/user_service.dart';
import 'package:recipe_recommendation/widgets/home/add_ingredients_title.dart';
import 'package:recipe_recommendation/widgets/home/camera_scan_card.dart';
import 'package:recipe_recommendation/widgets/home/home_header.dart';
import 'package:recipe_recommendation/widgets/home/manually_add_ingredient.dart';
import 'package:recipe_recommendation/widgets/home/recent_activity.dart';
import 'package:recipe_recommendation/widgets/home/recent_activity_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: UserService.getUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final username = snapshot.data ?? "Chef";

        return Scaffold(
          body: Column(
            children: [
              HomeHeader(username: username,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      AddIngredientsTitle(),
                      CameraScanCard(),
                      ManuallyAddIngredient(),
                      SizedBox(height: 30),
                      RecentActivity(),
                      RecentActivityList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
