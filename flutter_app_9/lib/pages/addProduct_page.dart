import 'package:flutter/material.dart';
import '../models/device.dart';
import '../api/instance.dart';

class AddProductPage extends StatefulWidget {
  final ApiService apiService;

  const AddProductPage({super.key, required this.apiService});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить товар'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Категория'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Количество'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      categoryController.text.isNotEmpty &&
                      quantityController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      imageUrlController.text.isNotEmpty) {
                    final newDevice = Device(
                      id: DateTime.now().millisecondsSinceEpoch,
                      description: descriptionController.text,
                      quantity: int.parse(quantityController.text),
                      category: categoryController.text,
                      name: nameController.text,
                      price: int.parse(priceController.text),
                      imageUrl: imageUrlController.text,
                      isFavorite: false,
                    );
                    try {
                      await widget.apiService.addDevice(newDevice);
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ошибка при добавлении товара: $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Пожалуйста, заполните все поля')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(0, 48),
                ),
                child: const Text(
                  'Добавить новый товар',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
