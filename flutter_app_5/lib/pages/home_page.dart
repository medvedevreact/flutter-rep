import 'package:flutter/material.dart';
import '../models/device.dart';
import '../components/device_component.dart';
import '../pages/addProduct_page.dart';

class HomePage extends StatefulWidget {
  final List<Device> devices; // Добавьте поле для списка устройств

  HomePage({super.key, required this.devices}); // Измените конструктор

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addDevice(Device newDevice) {
    setState(() {
      widget.devices.add(newDevice); // Обновите использование devices на widget.devices
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      widget.devices[index].isFavorite = !widget.devices[index].isFavorite; // Обновите использование devices
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
            crossAxisCount: 2, // Две колонки
            crossAxisSpacing: 10.0, // Расстояние между колонками
            mainAxisSpacing: 10.0,  // Расстояние между строками
            childAspectRatio: 0.7,  // Соотношение сторон для более вытянутой карточки
          ),
          itemCount: widget.devices.length, // Используйте widget.devices
          itemBuilder: (BuildContext context, int index) {
            return DeviceCard(
              device: widget.devices[index], // Используйте widget.devices
              onFavoriteToggle: (isFavorite) => _toggleFavorite(index),
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
