import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Register Logic
  Future<User?> register({required String email, required String password, required String username}) async {
    try {
      // creates user in firebase auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = cred.user!.uid;

      // store the data in firebase firestore db
      await _db.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'favourite_recipe_ids': [],
        'created_at': FieldValue.serverTimestamp(),
      });

      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  // Login Logic
  Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      rethrow;
    }
  }

  // Logout Logic
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Defining a getter to access current user
  User? get currentUser => _auth.currentUser;
}
