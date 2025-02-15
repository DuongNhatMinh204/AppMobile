import 'package:app_du_lich/screens/manage_trip_screen.dart';
import 'package:app_du_lich/screens/manage_user_screen.dart';
import 'package:flutter/material.dart';

import 'add_destination_screen.dart';
import 'add_flight_screen.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng điều khiển Admin"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chào mừng Admin!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Quản lý tài khoản user
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageUsersScreen(),
                  ),
                );
              },
              child: Text("Quản lý tài khoản User"),
            ),

            SizedBox(height: 10),

            // Quản lý chuyến bay đã đặt
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageBookingsScreen(),
                  ),
                );
              },
              child: Text("Quản lý các chuyến đi"),
            ),

            SizedBox(height: 10),

            // Thêm địa điểm du lịch
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDestinationScreen(),
                  ),
                );
              },
              child: Text("Thêm địa điểm du lịch"),
            ),

            SizedBox(height: 10),

            // Thêm chuyến bay mới
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFlightScreen(),
                  ),
                );
              },
              child: Text("Thêm chuyến bay"),
            ),
          ],
        ),
      ),
    );
  }
}
