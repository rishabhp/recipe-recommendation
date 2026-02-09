import 'package:flutter/material.dart';
import 'package:recipe_recommendation/constants/diet_types.dart';
import 'package:recipe_recommendation/models/user_preferences.dart';
import 'package:recipe_recommendation/services/auth_service.dart';
import 'package:recipe_recommendation/services/user_preferences_service.dart';
import 'package:recipe_recommendation/utils/app_gradients.dart';
import 'package:recipe_recommendation/widgets/profile/allergy_section.dart';
import 'package:recipe_recommendation/widgets/profile/dietary_preference_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DietTypes dietType;
  late Set<String> intolerances;
  late Map<String, String> customRestrictions;

  final _service = UserPreferencesService();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final UserPreferences prefs = await _service.getPreferences();

    setState(() {
      dietType = prefs.dietType;
      intolerances = prefs.intolerances;
      customRestrictions = prefs.customRestrictions;

      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
              selectedDiet: dietType,
              onChanged: (diet) {
                setState(() => dietType = diet);
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
              selectedAllergies: intolerances,
              customAllergies: customRestrictions,
              onChanged:
                  (
                    Set<String> updatedAllergies,
                    Map<String, String> updatedCustom,
                  ) {
                    setState(() {
                      intolerances = updatedAllergies;
                      customRestrictions = updatedCustom;
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
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(width: 1.5, color: Colors.redAccent),
                  ),
                  child: const Text('Discard Changes'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    final prefs = UserPreferences(
                      dietType: dietType,
                      intolerances: intolerances,
                      customRestrictions: customRestrictions,
                    );
                    await _service.savePreferences(prefs);
                    if (!context.mounted) return;
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
