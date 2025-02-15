import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveBookingToFirestore(String selectedDestination, String selectedHotel, String selectedFlight, int participants, double totalPrice) async {
    try {
      String userId = _auth.currentUser!.uid; // Lấy userId hiện tại

      await _firestore.collection('bookings').add({
        'userId': userId,
        'destination': selectedDestination,
        'hotel': selectedHotel,
        'flight': selectedFlight,
        'participants': participants,
        'totalPrice': totalPrice,
        'timestamp': FieldValue.serverTimestamp(), // Lưu thời gian đặt
      });

      print("Booking saved successfully!");
    } catch (error) {
      print("Failed to save booking: $error");
    }
  }
}
