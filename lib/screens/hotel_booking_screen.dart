import 'package:flutter/material.dart';
import 'flight_booking_screen.dart';

class HotelBookingScreen extends StatefulWidget {
  final String selectedDestination;
  final int participants;

  const HotelBookingScreen({
    required this.selectedDestination,
    required this.participants,
    Key? key,
  }) : super(key: key);

  @override
  _HotelBookingScreenState createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  final List<Map<String, dynamic>> hotels = [
    {
      "name": "Hà Nội Plaza",
      "price": 100,
      "image": "assets/images/hotel_hanoi.jpg",
    },
    {
      "name": "Sài Gòn Luxury",
      "price": 120,
      "image": "assets/images/hotel_saigon.jpg",
    },
    {
      "name": "Đà Nẵng View",
      "price": 90,
      "image": "assets/images/hotel_danang.jpg",
    },
  ];

  void _selectHotel(Map<String, dynamic> hotel) {
    final double totalPrice = (hotel["price"] as num).toDouble() * widget.participants.toDouble();

    print("Khách sạn được chọn: ${hotel["name"]}"); // Kiểm tra log
    // Chuyển ngay sang trang đặt máy bay
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightBookingScreen(
          selectedDestination: widget.selectedDestination,
          selectedHotel: hotel["name"],
          participants: widget.participants,
          totalHotelPrice: totalPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chọn khách sạn")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            final hotel = hotels[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () => _selectHotel(hotel), // Chuyển trang khi chọn khách sạn
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        hotel["image"],
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel["name"],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Giá: \$${hotel["price"]}/người/đêm",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
