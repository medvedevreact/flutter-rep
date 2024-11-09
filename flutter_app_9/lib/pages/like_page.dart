import 'package:flutter/material.dart';
import '../models/device.dart';
import '../components/device_component.dart';
import '../api/instance.dart';

class LikePage extends StatelessWidget {
  final List<Device> favoriteDevices;
  final Function(Device) addToCart;
  final ApiService apiService;

  const LikePage({
    super.key,
    required this.favoriteDevices,
    required this.addToCart,
    required this.apiService,
  });

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
          ? const Center(child: Text('Нет избранных товаров'))
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.7,
          ),
          itemCount: favoriteDevices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceCard(
              device: favoriteDevices[index],
              onFavoriteToggle: (isFavorite) {},
              addToCart: addToCart,
              apiService: apiService,
            );
          },
        ),
      ),
    );
  }
}
