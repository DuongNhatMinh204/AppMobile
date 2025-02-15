import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';

class FlightBookingScreen extends StatefulWidget {
  final String selectedDestination;
  final String selectedHotel;
  final int participants;
  final double totalHotelPrice;

  const FlightBookingScreen({
    required this.selectedDestination,
    required this.selectedHotel,
    required this.participants,
    required this.totalHotelPrice,
    Key? key,
  }) : super(key: key);

  @override
  _FlightBookingScreenState createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  final List<Map<String, dynamic>> flights = [
    {
      "airline": "Vietnam Airlines",
      "price": 200,
      "time": "08:00",
      "date": "2025-03-15",
    },
    {
      "airline": "Bamboo Airways",
      "price": 180,
      "time": "02:30",
      "date": "2025-03-16",
    },
    {
      "airline": "Vietjet Air",
      "price": 150,
      "time": "06:00",
      "date": "2025-03-17",
    },
  ];

  void _selectFlight(Map<String, dynamic> flight) {
    final double totalFlightPrice =
        (flight["price"] as num).toDouble() * widget.participants.toDouble();

    // Định dạng lại thời gian để tránh lỗi DateTime.parse()
    String flightTime = flight['time'].trim(); // Xóa khoảng trắng thừa

    // Chuyển đổi thành DateTime hợp lệ
    DateTime selectedDateTime = DateTime.parse("${flight['date']}T$flightTime:00");

    debugPrint("Flight selected: ${flight["airline"]}");

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmationScreen(
              selectedDestination: widget.selectedDestination,
              selectedHotel: widget.selectedHotel,
              participants: widget.participants,
              totalHotelPrice: widget.totalHotelPrice,
              selectedFlight: flight["airline"],
              selectedClass: "Economy",
              totalFlightPrice: totalFlightPrice,
              selectedDateTime: selectedDateTime,
              totalPrice: widget.totalHotelPrice + totalFlightPrice,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chọn chuyến bay")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: flights.length,
          itemBuilder: (context, index) {
            final flight = flights[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () => _selectFlight(flight),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.flight, color: Colors.blue, size: 40),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flight["airline"],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Giờ: ${flight["time"]}, Ngày: ${flight["date"]}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${flight["price"]}/người",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
