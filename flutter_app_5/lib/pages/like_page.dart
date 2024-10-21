import 'package:flutter/material.dart';
import '../models/device.dart';
import '../components/device_component.dart';

class LikePage extends StatelessWidget {
  final List<Device> favoriteDevices;

  const LikePage({super.key, required this.favoriteDevices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: favoriteDevices.isEmpty
          ? Center(
        child: Text(
          'Избранное пусто',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Две колонки
            crossAxisSpacing: 10.0, // Расстояние между колонками
            mainAxisSpacing: 10.0,  // Расстояние между строками
            childAspectRatio: 0.7,  // Соотношение сторон для более вытянутой карточки
          ),
          itemCount: favoriteDevices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceCard(device: favoriteDevices[index], onFavoriteToggle: (isFavorite) {});
          },
        ),
      ),
    );
  }
}
