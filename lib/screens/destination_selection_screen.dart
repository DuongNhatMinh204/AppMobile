//
// import 'package:flutter/material.dart';
// import 'package:diacritic/diacritic.dart'; // Import thư viện xóa dấu
// import 'hotel_booking_screen.dart';
//
// class DestinationSelectionScreen extends StatefulWidget {
//   @override
//   _DestinationSelectionScreenState createState() =>
//       _DestinationSelectionScreenState();
// }
//
// class _DestinationSelectionScreenState extends State<DestinationSelectionScreen> {
//   int participants = 1;
//   String searchQuery = ""; // Biến lưu giá trị tìm kiếm
//
//   final List<Map<String, String>> destinations = [
//     {"name": "Hà Nội", "image": "assets/images/hanoi.jpg"},
//     {"name": "Hồ Chí Minh", "image": "assets/images/hochiminh.jpg"},
//     {"name": "Đà Nẵng", "image": "assets/images/danang.jpg"},
//     {"name": "Nha Trang", "image": "assets/images/nhatrang.jpg"},
//     {"name": "Huế", "image": "assets/images/hue.jpg"},
//     {"name": "Phú Quốc", "image": "assets/images/phuquoc.jpg"},
//     {"name": "An Giang", "image": "assets/images/an_giang.jpg"},
//     {"name": "Bến Tre", "image": "assets/images/ben_tre.jpg"},
//     {"name": "Cà Mau", "image": "assets/images/ca_mau.jpg"},
//     {"name": "Cao Bằng", "image": "assets/images/cao_bang.jpg"},
//     {"name": "Hải Phòng", "image": "assets/images/hai_phong.jpg"},
//     {"name": "Ninh Bình", "image": "assets/images/ninh_binh.jpg"},
//     {"name": "Quảng Ninh", "image": "assets/images/quang_ninh.jpg"},
//     {"name": "Thái Bình", "image": "assets/images/thai_binh.jpg"},
//     {"name": "Vũng Tàu", "image": "assets/images/vung_tau.jpg"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // Danh sách sau khi lọc theo từ khóa tìm kiếm
//     final filteredDestinations = destinations.where((destination) {
//       final name = removeDiacritics(destination["name"]!.toLowerCase()); // Xóa dấu tiếng Việt
//       final query = removeDiacritics(searchQuery.toLowerCase()); // Xóa dấu từ khóa tìm kiếm
//       return name.contains(query);
//     }).toList();
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Chọn địa điểm du lịch")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Thanh tìm kiếm
//             TextField(
//               decoration: InputDecoration(
//                 hintText: "Tìm kiếm địa điểm...",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   searchQuery = value; // Cập nhật từ khóa tìm kiếm
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Text("Số người tham gia:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             DropdownButton<int>(
//               value: participants,
//               items: List.generate(10, (index) => index + 1).map((int value) {
//                 return DropdownMenuItem<int>(
//                   value: value,
//                   child: Text(value.toString(), style: TextStyle(fontSize: 18)),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   participants = newValue!;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemCount: filteredDestinations.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HotelBookingScreen(
//                             selectedDestination: filteredDestinations[index]["name"]!,
//                             participants: participants,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       elevation: 5,
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.asset(
//                               filteredDestinations[index]["image"]!,
//                               width: double.infinity,
//                               height: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.black.withOpacity(0.4),
//                             ),
//                           ),
//                           Center(
//                             child: Text(
//                               filteredDestinations[index]["name"]!,
//                               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart'; // Thư viện để loại bỏ dấu tiếng Việt
import 'hotel_booking_screen.dart';

class DestinationSelectionScreen extends StatefulWidget {
  @override
  _DestinationSelectionScreenState createState() =>
      _DestinationSelectionScreenState();
}

class _DestinationSelectionScreenState extends State<DestinationSelectionScreen> {
  int participants = 1;
  String searchQuery = ""; // Biến lưu giá trị tìm kiếm

  final List<Map<String, String>> fixedDestinations = [
    {"name": "Hà Nội", "image": "assets/images/hanoi.jpg"},
    {"name": "Hồ Chí Minh", "image": "assets/images/hochiminh.jpg"},
    {"name": "Đà Nẵng", "image": "assets/images/danang.jpg"},
    {"name": "Nha Trang", "image": "assets/images/nhatrang.jpg"},
    {"name": "Huế", "image": "assets/images/hue.jpg"},
    {"name": "Phú Quốc", "image": "assets/images/phuquoc.jpg"},
    {"name": "An Giang", "image": "assets/images/an_giang.jpg"},
    {"name": "Bến Tre", "image": "assets/images/ben_tre.jpg"},
    {"name": "Cà Mau", "image": "assets/images/ca_mau.jpg"},
    {"name": "Cao Bằng", "image": "assets/images/cao_bang.jpg"},
    {"name": "Hải Phòng", "image": "assets/images/hai_phong.jpg"},
    {"name": "Ninh Bình", "image": "assets/images/ninh_binh.jpg"},
    {"name": "Quảng Ninh", "image": "assets/images/quang_ninh.jpg"},
    {"name": "Thái Bình", "image": "assets/images/thai_binh.jpg"},
    {"name": "Vũng Tàu", "image": "assets/images/vung_tau.jpg"},
  ];

  List<Map<String, String>> firestoreDestinations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDestinationsFromFirestore();
  }

  Future<void> fetchDestinationsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('destinations').get();

      List<Map<String, String>> fetchedDestinations = querySnapshot.docs.map((doc) {
        return {
          "name": doc["name"].toString() ?? "Không xác định",
          "image": doc["imageUrl"].toString() ?? "assets/images/default.jpg",
        };
      }).toList();

      setState(() {
        firestoreDestinations = fetchedDestinations;
        isLoading = false;
      });
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ Firestore: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> allDestinations = [...fixedDestinations, ...firestoreDestinations];

    final filteredDestinations = allDestinations.where((destination) {
      final name = removeDiacritics(destination["name"]!.toLowerCase());
      final query = removeDiacritics(searchQuery.toLowerCase());
      return name.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Chọn địa điểm du lịch")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm địa điểm...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 10),
            Text("Số người tham gia:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredDestinations.isEmpty
                  ? Center(child: Text("Không tìm thấy địa điểm nào."))
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredDestinations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelBookingScreen(
                            selectedDestination: filteredDestinations[index]["name"]!,
                            participants: participants,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 5,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: filteredDestinations[index]["image"]!.startsWith("http")
                                ? Image.network(
                              filteredDestinations[index]["image"]!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              filteredDestinations[index]["image"]!,
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
                              filteredDestinations[index]["name"]!,
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
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
