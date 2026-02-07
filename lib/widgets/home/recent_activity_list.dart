import 'package:flutter/material.dart';
import 'package:recipe_recommendation/widgets/icon_box.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final recentItems = [
      {'name': 'Palak Paneer', 'time': '2 Days Ago'},
      {'name': 'Green Salad', 'time': '5 Days Ago'},
      {'name': 'Palak Paneer', 'time': '2 Days Ago'},
      {'name': 'Green Salad', 'time': '5 Days Ago'},
    ];

    return Column(
      children: List.generate(recentItems.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBox(
                icon: Icons.access_time,
                backgroundColor: Colors.lightGreen.shade200,
                iconColor: Colors.green.shade800,
              ),
              Text(recentItems[index]['name']!),
              Text(recentItems[index]['time']!),
            ],
          ),
        );
      }),
    );
  }
}
