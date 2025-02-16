// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import '../services/auth_service.dart';
// // import 'home_screen.dart';
// // import 'admin_dashboard.dart';
// //
// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   final AuthService authService = AuthService();
// //   final TextEditingController phoneController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //
// //   void login() async {
// //     String phone = phoneController.text.trim();
// //     String password = passwordController.text.trim();
// //
// //     if (phone.isEmpty || password.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
// //       );
// //       return;
// //     }
// //
// //     bool success = await authService.loginUser(phone, password);
// //
// //     if (success) {
// //       var userDoc =
// //       await FirebaseFirestore.instance.collection("users").doc(phone).get();
// //
// //       if (userDoc.exists) {
// //         String role = userDoc.data()?["role"] ?? "user";
// //
// //         if (role == "admin") {
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => AdminDashboard()),
// //           );
// //         } else {
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => HomeScreen()),
// //           );
// //         }
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Tài khoản không tồn tại!")),
// //         );
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Số điện thoại hoặc mật khẩu không đúng!")),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Đăng nhập")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: phoneController,
// //               decoration: InputDecoration(labelText: "Số điện thoại"),
// //             ),
// //             TextField(
// //               controller: passwordController,
// //               decoration: InputDecoration(labelText: "Mật khẩu"),
// //               obscureText: true,
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: login,
// //               child: Text("Đăng nhập"),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pushNamed(context, "/register");
// //               },
// //               child: Text("Chưa có tài khoản? Đăng ký ngay"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
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
//   late VideoPlayerController _videoController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.asset("assets/images/ocean.mp4")
//       ..initialize().then((_) {
//         setState(() {});
//         _videoController.setLooping(true);
//         _videoController.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }
//
//   void login() async {
//     String phone = phoneController.text.trim();
//     String password = passwordController.text.trim();
//
//     if (phone.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
//       );
//       return;
//     }
//
//     bool success = await authService.loginUser(phone, password);
//
//     if (success) {
//       var userDoc = await FirebaseFirestore.instance.collection("users").doc(phone).get();
//
//       if (userDoc.exists) {
//         String role = userDoc.data()?["role"] ?? "user";
//
//         if (role == "admin") {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => AdminDashboard()),
//           );
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Tài khoản không tồn tại!")),
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
//       body: Stack(
//         children: [
//           // Video nền
//           SizedBox.expand(
//             child: FittedBox(
//               fit: BoxFit.cover,
//               child: SizedBox(
//                 width: _videoController.value.size?.width ?? 0,
//                 height: _videoController.value.size?.height ?? 0,
//                 child: VideoPlayer(_videoController),
//               ),
//             ),
//           ),
//           // Overlay màu tối để dễ nhìn nội dung
//           Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//           // Nội dung form đăng nhập
//           Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               child: Card(
//                 color: Colors.white.withOpacity(0.8),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 child: Padding(
//                   padding: EdgeInsets.all(24),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Đăng Nhập",
//                         style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
//                       ),
//                       SizedBox(height: 20),
//                       TextField(
//                         controller: phoneController,
//                         decoration: InputDecoration(
//                           labelText: "Số điện thoại",
//                           prefixIcon: Icon(Icons.phone),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       TextField(
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                           labelText: "Mật khẩu",
//                           prefixIcon: Icon(Icons.lock),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         obscureText: true,
//                       ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
//                         ),
//                         child: Text("Đăng nhập", style: TextStyle(fontSize: 18)),
//                       ),
//                       SizedBox(height: 10),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, "/register");
//                         },
//                         child: Text("Chưa có tài khoản? Đăng ký ngay"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/images/ocean.mp4")
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

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
      var userDoc = await FirebaseFirestore.instance.collection("users").doc(phone).get();

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
      body: Stack(
        children: [
          // Video nền
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size?.width ?? 0,
                height: _videoController.value.size?.height ?? 0,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
          // Overlay màu tối giúp nội dung rõ ràng hơn
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Nội dung form đăng nhập đè lên video
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Đăng Nhập",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Số điện thoại",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.phone, color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Mật khẩu",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    ),
                    child: Text("Đăng nhập", style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text("Chưa có tài khoản? Đăng ký ngay", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
