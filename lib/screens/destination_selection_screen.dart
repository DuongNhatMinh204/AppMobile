import 'package:flutter/material.dart';
import 'hotel_booking_screen.dart';

class DestinationSelectionScreen extends StatefulWidget {
  @override
  _DestinationSelectionScreenState createState() =>
      _DestinationSelectionScreenState();
}

class _DestinationSelectionScreenState extends State<DestinationSelectionScreen> {
  int participants = 1; // Số người tham gia mặc định

  // Danh sách các địa điểm du lịch
  final List<Map<String, String>> destinations = [
    {"name": "Hà Nội", "image": "assets/images/hanoi.jpg"},
    {"name": "Hồ Chí Minh", "image": "assets/images/hochiminh.jpg"},
    {"name": "Đà Nẵng", "image": "assets/images/danang.jpg"},
    {"name": "Nha Trang", "image": "assets/images/nhatrang.jpg"},
    {"name": "Huế", "image": "assets/images/hue.jpg"},
    {"name": "Phú Quốc", "image": "assets/images/phuquoc.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chọn địa điểm du lịch")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Số người tham gia:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<int>(
              value: participants,
              items: List.generate(10, (index) => index + 1).map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString(), style: TextStyle(fontSize: 18)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  participants = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Mỗi hàng hiển thị 2 cột
                  crossAxisSpacing: 10, // Khoảng cách giữa các cột
                  mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                  childAspectRatio: 0.8, // Điều chỉnh tỷ lệ giữa chiều rộng và chiều cao
                ),
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelBookingScreen(
                            selectedDestination: destinations[index]["name"]!,
                            participants: participants,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              destinations[index]["image"]!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          Center(
                            child: Text(
                              destinations[index]["name"]!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
