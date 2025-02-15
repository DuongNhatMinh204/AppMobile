import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String selectedDestination;
  final String selectedHotel;
  final int participants;
  final double totalHotelPrice;
  final String selectedFlight;
  final String selectedClass;
  final double totalFlightPrice;
  final DateTime selectedDateTime;
  final double totalPrice;

  const BookingConfirmationScreen({
    required this.selectedDestination,
    required this.selectedHotel,
    required this.participants,
    required this.totalHotelPrice,
    required this.selectedFlight,
    required this.selectedClass,
    required this.totalFlightPrice,
    required this.selectedDateTime,
    required this.totalPrice,
    Key? key,
  }) : super(key: key);

  void _confirmBooking(BuildContext context) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Tạo dữ liệu đặt chuyến đi
    Map<String, dynamic> bookingData = {
      "destination": selectedDestination,
      "hotel": selectedHotel,
      "flight": selectedFlight,
      "participants": participants,
      "totalPrice": totalPrice,
      "userId": "1", // TODO: Thay bằng ID thực của user
      "dateTime": selectedDateTime.toIso8601String(),
    };

    // Lưu vào Firestore (collection: bookings)
    await _firestore.collection("bookings").add(bookingData);

    // Hiển thị thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đặt chuyến đi thành công!")),
    );

    // Quay về màn hình chính hoặc màn hình lịch sử đặt vé
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xác nhận đặt chuyến đi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Điểm đến: $selectedDestination", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Khách sạn: $selectedHotel", style: const TextStyle(fontSize: 16)),
            Text("Chuyến bay: $selectedFlight ($selectedClass)", style: const TextStyle(fontSize: 16)),
            Text("Số lượng khách: $participants", style: const TextStyle(fontSize: 16)),
            Text("Ngày & Giờ: ${selectedDateTime.toLocal()}", style: const TextStyle(fontSize: 16)),
            Text("Tổng giá: \$${totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmBooking(context),
              child: const Text("Hoàn tất"),
            ),
          ],
        ),
      ),
    );
  }
}
