import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Thêm dữ liệu người dùng khi đăng ký
  Future<void> addUser(String uid, String name, String email) async {
    return await _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Lấy thông tin người dùng từ Firestore
  Future<DocumentSnapshot> getUser(String uid) async {
    return await _db.collection('users').doc(uid).get();
  }

  // Cập nhật thông tin người dùng
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    return await _db.collection('users').doc(uid).update(data);
  }

  // Xóa người dùng
  Future<void> deleteUser(String uid) async {
    return await _db.collection('users').doc(uid).delete();
  }

  // Lấy danh sách tất cả người dùng
  Stream<QuerySnapshot> getUsers() {
    return _db.collection('users').snapshots();
  }
}
