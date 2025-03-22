import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signup(
      String name, String email, String password, String dob, String address, String doj, String role, double salary) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          "name": name,
          "email": email,
          "dob": dob,
          "address": address,
          "doj": doj,
          "role": role,
          "salary": salary,
          "isAdmin": false,  // Default to false; manually changed later
        });
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isAdmin(User user) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(user.uid).get();
    return doc.exists ? doc["isAdmin"] : false;
  }
}
