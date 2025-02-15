import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Đăng ký tài khoản
  Future<bool> registerUser(String phone, String password) async {
    try {
      // Kiểm tra số điện thoại đã tồn tại chưa
      var userExists = await _firestore.collection("users").doc(phone).get();
      if (userExists.exists) {
        print("Số điện thoại đã được đăng ký.");
        return false;
      }

      // Lưu tài khoản vào Firestore
      await _firestore.collection("users").doc(phone).set({
        "phone": phone,
        "password": password, // Không nên lưu password thẳng như thế này
      });

      print("Đăng ký thành công!");
      return true;
    } catch (e) {
      print("Lỗi khi đăng ký: $e");
      return false;
    }
  }

  // Đăng nhập tài khoản
  Future<bool> loginUser(String phone, String password) async {
    try {
      var userDoc = await _firestore.collection("users").doc(phone).get();
      if (userDoc.exists) {
        if (userDoc.data()?["password"] == password) {
          print("Đăng nhập thành công!");
          return true;
        } else {
          print("Mật khẩu không đúng.");
          return false;
        }
      } else {
        print("Số điện thoại chưa được đăng ký.");
        return false;
      }
    } catch (e) {
      print("Lỗi khi đăng nhập: $e");
      return false;
    }
  }
}
