import 'package:flutter/material.dart';

class AddIngredientSection extends StatefulWidget {
  final void Function(String ingredient) onAdd;

  const AddIngredientSection({super.key, required this.onAdd});

  @override
  State<AddIngredientSection> createState() => _AddIngredientSectionState();
}

class _AddIngredientSectionState extends State<AddIngredientSection> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        hintText: 'Type ingredient name...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: Icon(Icons.search),
        suffixIcon: Container(
          width: 48,
          margin: EdgeInsets.only(right: 6),
          child: ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              widget.onAdd(text);
              controller.clear();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }
}