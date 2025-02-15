import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDestinationScreen extends StatefulWidget {
  @override
  _AddDestinationScreenState createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isUploading = false;

  Future<void> _uploadDestination() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập tên địa điểm")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Ảnh mặc định
      String imageUrl = "assets/images/hanoi.jpg";

      // Lưu thông tin vào Firestore
      await FirebaseFirestore.instance.collection("destinations").add({
        "name": _nameController.text.trim(),
        "imageUrl": imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thêm địa điểm thành công!")),
      );

      // Xóa dữ liệu sau khi upload
      _nameController.clear();
      setState(() {
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi thêm địa điểm: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm địa điểm")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Tên địa điểm"),
            ),
            SizedBox(height: 20),
            Image.asset("assets/images/hanoi.jpg", height: 200),
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _uploadDestination,
              child: Text("Thêm địa điểm"),
            ),
          ],
        ),
      ),
    );
  }
}
