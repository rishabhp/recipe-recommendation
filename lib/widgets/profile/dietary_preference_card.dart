import 'package:flutter/material.dart';

class DietaryPreferenceCard extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedBorderColor;
  final Color selectedBackgroundColor;

  const DietaryPreferenceCard({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.selectedBorderColor,
    required this.selectedBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected ? selectedBorderColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
