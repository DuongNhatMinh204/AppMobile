// import 'package:flutter/material.dart';
// import 'destination_selection_screen.dart';
// import 'history_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Trang chủ"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushReplacementNamed(context, "/login");
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DestinationSelectionScreen(),
//                   ),
//                 );
//               },
//               child: Text("Book"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HistoryScreen(),
//                   ),
//                 );
//               },
//               child: Text("History"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'destination_selection_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trang chủ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Căn giữa tiêu đề
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.orange),
            onPressed: () {
              // Điều hướng về màn hình đăng nhập
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity, // Chiều rộng toàn màn hình
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue], // Nền gradient xanh
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nút đặt vé (Book)
            ElevatedButton.icon(
              icon: Icon(Icons.flight_takeoff), // Biểu tượng máy bay
              label: Text(
                "Đặt vé ngay",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.orangeAccent, // Màu cam nổi bật
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DestinationSelectionScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 30), // Khoảng cách giữa các nút

            // Nút xem lịch sử (History)
            ElevatedButton.icon(
              icon: Icon(Icons.history), // Biểu tượng lịch sử
              label: Text(
                "Lịch sử đặt vé",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.green, // Màu xanh lá cây
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
