import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý các chuyến đi"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Không có chuyến đi nào."));
          }

          var bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text("Mã đặt chỗ: ${booking.id}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Người đặt: ${booking['userId']}"),
                      Text("Điểm đến: ${booking['destination']}"),
                      Text("Ngày đi: ${booking['dateTime']}"),
                      Text("Số người : ${booking['participants']}"),
                      Text("Hotel: ${booking['hotel']}"),
                      Text("Chuyến bay : ${booking['flight']}"),
                      Text("Tổng tiền : ${booking['totalPrice']}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteBooking(booking.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _deleteBooking(String bookingId) {
    FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete();
  }
}
