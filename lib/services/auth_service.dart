// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan user saat ini
  User? get currentUser => _auth.currentUser;

  // 1. REGISTER
  Future<String?> register({
    required String email,
    required String password,
    required String username,
    required String role, // 'Job Seeker' atau 'Company'
  }) async {
    try {
      // Create user di Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create data profil awal di Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'username': username,
        'email': email,
        'role': role,
        'bio': 'Pengguna baru di Gawee App', // Default bio
        'job_title': role == 'Company' ? 'Recruiter' : 'Fresh Graduate',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // Sukses
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }

  // 2. LOGIN
  Future<String?> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Sukses
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 3. LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}