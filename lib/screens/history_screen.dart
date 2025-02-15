import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchBookings() async {
    QuerySnapshot querySnapshot =
    await _firestore.collection("bookings").get();

    return querySnapshot.docs.map((doc) {
      return {
        "destination": doc["destination"],
        "hotel": doc["hotel"],
        "flight": doc["flight"],
        "participants": doc["participants"],
        "totalPrice": doc["totalPrice"],
        "dateTime": doc["dateTime"],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lịch Sử Đặt Vé")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Không có lịch sử đặt vé."));
          }

          List<Map<String, dynamic>> bookings = snapshot.data!;
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text("Điểm đến: ${booking["destination"]}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Khách sạn: ${booking["hotel"]}"),
                      Text("Chuyến bay: ${booking["flight"]}"),
                      Text("Số lượng khách: ${booking["participants"]}"),
                      Text("Tổng giá: \$${booking["totalPrice"]}"),
                      Text("Ngày giờ: ${booking["dateTime"]}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
