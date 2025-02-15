import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Đăng ký tài khoản
  Future<User?> register(String email, String password, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Lưu role vào Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "email": email,
        "role": role,
      });

      return userCredential.user;
    } catch (e) {
      print("Lỗi đăng ký: $e");
      return null;
    }
  }

  // Đăng nhập
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Lỗi đăng nhập: $e");
      return null;
    }
  }

  // Đăng xuất
  Future<void> logout() async {
    await _auth.signOut();
  }
}
