import 'package:flutter/material.dart';
import 'package:recipe_recommendation/models/diet_types.dart';
import 'package:recipe_recommendation/services/auth_service.dart';
import 'package:recipe_recommendation/utils/app_gradients.dart';
import 'package:recipe_recommendation/widgets/profile/allergy_section.dart';
import 'package:recipe_recommendation/widgets/profile/dietary_preference_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DietTypes savedDiet;
  late Set<String> savedSelectedAllergies;
  late Map<String, String> savedCustomAllergies;

  late DietTypes draftDiet;
  late Set<String> draftSelectedAllergies;
  late Map<String, String> draftCustomAllergies;

  @override
  void initState() {
    super.initState();

    // TODO : replace these values with values loaded from Firestore / Hive
    savedDiet = DietTypes.nonveg;
    savedSelectedAllergies = {};
    savedCustomAllergies = {};

    draftDiet = savedDiet;
    draftSelectedAllergies = Set.from(savedSelectedAllergies);
    draftCustomAllergies = Map.from(savedCustomAllergies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Profile Preference',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Edit your food preference',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await AuthService().logout();

              if (!context.mounted) return;

              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            const Text(
              'Dietary Preference',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            DietaryPreferenceSection(
              selectedDiet: draftDiet,
              onChanged: (diet) {
                setState(() => draftDiet = diet);
              },
            ),

            const SizedBox(height: 32),

            const Text(
              'Allergies & Restrictions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Select any ingredient you want to avoid'),
            const SizedBox(height: 16),
            AllergySection(
              selectedAllergies: draftSelectedAllergies,
              customAllergies: draftCustomAllergies,
              onChanged:
                  (
                    Set<String> updatedAllergies,
                    Map<String, String> updatedCustom,
                  ) {
                    setState(() {
                      draftSelectedAllergies = updatedAllergies;
                      draftCustomAllergies = updatedCustom;
                    });
                  },
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      draftDiet = savedDiet;
                      draftSelectedAllergies = Set.from(savedSelectedAllergies);
                      draftCustomAllergies = Map.from(savedCustomAllergies);
                    });

                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(width: 1.5, color: Colors.redAccent),
                  ),
                  child: const Text('Discard Changes'),
                ),

                ElevatedButton(
                  onPressed: () {
                    // TODO : Save changes in Firestore / Hive
                    setState(() {
                      savedDiet = draftDiet;
                      savedSelectedAllergies = Set.from(draftSelectedAllergies);
                      savedCustomAllergies = Map.from(draftCustomAllergies);
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 4,
                  ),
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
