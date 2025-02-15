// import 'package:app_du_lich/screens/destination_selection_screen.dart';
// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
// import 'home_screen.dart';
// import 'admin_dashboard.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService authService = AuthService();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isAdmin = false; // Biến kiểm tra người dùng có phải admin không
//
//   void login() async {
//     bool success = await authService.loginUser(
//       phoneController.text.trim(),
//       passwordController.text.trim(),
//     );
//
//     if (success) {
//       // Kiểm tra xem người dùng có phải admin không
//       if (phoneController.text.trim() == "admin") {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => AdminDashboard()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) =>HomeScreen()),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Số điện thoại hoặc mật khẩu không đúng!")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Đăng nhập")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(labelText: "Số điện thoại"),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: "Mật khẩu"),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: login,
//               child: Text("Đăng nhập"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, "/register");
//               },
//               child: Text("Chưa có tài khoản? Đăng ký ngay"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'home_screen.dart'; // Màn hình user
// // import 'admin_dashboard.dart'; // Màn hình admin
// //
// // class LoginScreen extends StatelessWidget {
// //   final TextEditingController phoneController = TextEditingController();
// //
// //   void _login(BuildContext context) async {
// //     String phone = phoneController.text.trim();
// //
// //     if (phone.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Vui lòng nhập số điện thoại")),
// //       );
// //       return;
// //     }
// //
// //     var userDoc = await FirebaseFirestore.instance
// //         .collection("users")
// //         .doc(phone)
// //         .get();
// //
// //     if (userDoc.exists) {
// //       String role = userDoc.data()?["role"] ?? "user";
// //
// //       if (role == "admin") {
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => AdminDashboard()),
// //         );
// //       } else {
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => HomeScreen()),
// //         );
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Số điện thoại không tồn tại")),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Đăng nhập")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: phoneController,
// //               keyboardType: TextInputType.phone,
// //               decoration: InputDecoration(labelText: "Số điện thoại"),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () => _login(context),
// //               child: Text("Đăng nhập"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    bool success = await authService.loginUser(phone, password);

    if (success) {
      var userDoc =
      await FirebaseFirestore.instance.collection("users").doc(phone).get();

      if (userDoc.exists) {
        String role = userDoc.data()?["role"] ?? "user";

        if (role == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tài khoản không tồn tại!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Số điện thoại hoặc mật khẩu không đúng!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Số điện thoại"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Mật khẩu"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text("Đăng nhập"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              child: Text("Chưa có tài khoản? Đăng ký ngay"),
            ),
          ],
        ),
      ),
    );
  }
}
