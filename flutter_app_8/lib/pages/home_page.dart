import 'package:flutter/material.dart';
import '../models/device.dart';
import '../components/device_component.dart';
import '../pages/addProduct_page.dart';

class HomePage extends StatefulWidget {
  final List<Device> devices;
  final Function(Device) addToCart;

  HomePage({super.key, required this.devices, required this.addToCart});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addDevice(Device newDevice) {
    setState(() {
      widget.devices.add(newDevice);
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      widget.devices[index].isFavorite = !widget.devices[index].isFavorite;
    });
  }

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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.7,
          ),
          itemCount: widget.devices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceCard(
              device: widget.devices[index],
              onFavoriteToggle: (isFavorite) => _toggleFavorite(index),
              addToCart: widget.addToCart,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                onAddDevice: _addDevice,
              ),
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
