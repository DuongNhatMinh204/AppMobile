import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFlightScreen extends StatefulWidget {
  @override
  _AddFlightScreenState createState() => _AddFlightScreenState();
}

class _AddFlightScreenState extends State<AddFlightScreen> {
  final TextEditingController airlineController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> addFlight() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseFirestore.instance.collection('flights').add({
        'airline': airlineController.text,
        'price': double.parse(priceController.text),
        'time': timeController.text,
        'date': dateController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chuyến bay đã được thêm!')),
      );

      // Xóa các trường nhập sau khi thêm thành công
      airlineController.clear();
      priceController.clear();
      timeController.clear();
      dateController.clear();
    } catch (e) {
      print("Lỗi khi thêm chuyến bay: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi thêm chuyến bay!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm Chuyến Bay")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: airlineController,
                decoration: InputDecoration(labelText: "Hãng hàng không"),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập hãng hàng không" : null,
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Giá vé"),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập giá vé" : null,
              ),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: "Giờ bay (HH:MM)"),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập giờ bay" : null,
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(labelText: "Ngày bay (YYYY-MM-DD)"),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập ngày bay" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addFlight,
                child: Text("Thêm Chuyến Bay"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
