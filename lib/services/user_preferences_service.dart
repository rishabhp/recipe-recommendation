import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_recommendation/models/user_preferences.dart';

class UserPreferencesService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  String get _uid => _auth.currentUser!.uid;

  Future<void> savePreferences(UserPreferences prefs) async {
    await _db.collection('users').doc(_uid).set(
      prefs.toFirestore(),
      SetOptions(merge: true),
    );
  }

  Future<UserPreferences> getPreferences() async {
    final doc = await _db.collection('users').doc(_uid).get();
    final data = doc.data() ?? {};
    return UserPreferences.fromFirestore(data);
  }
}