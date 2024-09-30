import 'package:flutter/material.dart';
import '../models/device.dart';
import '../components/device_component.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Device> devices = [
    Device(1, 'Portable Bluetooth Speaker', 8, 'Speakers', 'JBL Flip 6',
        12999, 'https://m.media-amazon.com/images/I/71DMsp+X-pL._AC_SX355_.jpg'),
    Device(2, 'Noise Cancelling Headphones', 5, 'Headphones', 'Sony WH-1000XM5',
        29999, 'https://m.media-amazon.com/images/I/61eeHPRFQ9L._AC_SX466_.jpg'),
    Device(3, 'Smartwatch with GPS', 12, 'Wearables', 'Apple Watch Series 8',
        39999, 'https://m.media-amazon.com/images/I/71ulah9iIwL.__AC_SY445_SX342_QL70_FMwebp_.jpg'),
    Device(4, 'Wireless Earbuds with Charging Case', 20, 'Earbuds', 'Samsung Galaxy Buds Pro',
        19999, 'https://m.media-amazon.com/images/I/712wbf6XxYL._AC_SL1500_.jpg'),
    Device(5, '4K Ultra HD Smart TV', 3, 'TVs', 'LG OLED C1 Series',
        99999, 'https://m.media-amazon.com/images/I/91EBhKZOkEL._AC_SL1500_.jpg'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог товаров'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceCard(device: devices[index]);
          },
        ),
      ),
    );
  }
}
