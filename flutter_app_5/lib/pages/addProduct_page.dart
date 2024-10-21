import 'package:flutter/material.dart';
import '../models/device.dart';

class AddProductPage extends StatefulWidget {
  final Function(Device) onAddDevice;

  const AddProductPage({super.key, required this.onAddDevice});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
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
              controller: titleController,
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
              decoration: const InputDecoration(labelText: 'Cсылка на изображение'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Проверяем, что количество и цена введены корректно
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      categoryController.text.isNotEmpty &&
                      quantityController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      imageUrlController.text.isNotEmpty) {
                    final newDevice = Device(
                      DateTime.now().millisecondsSinceEpoch,
                      descriptionController.text,
                      int.parse(quantityController.text),
                      categoryController.text,
                      titleController.text,
                      int.parse(priceController.text),
                      imageUrlController.text,
                      false
                    );
                    widget.onAddDevice(newDevice);
                    Navigator.pop(context);
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
