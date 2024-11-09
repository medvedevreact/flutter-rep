import 'package:flutter/material.dart';
import '../models/device.dart';
import '../api/instance.dart';

class EditDevicePage extends StatefulWidget {
  final int deviceId;
  final ApiService apiService;

  const EditDevicePage({
    super.key,
    required this.deviceId,
    required this.apiService,
  });

  @override
  _EditDevicePageState createState() => _EditDevicePageState();
}

class _EditDevicePageState extends State<EditDevicePage> {
  late Future<Device> _deviceFuture;
  late Device _device;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _deviceFuture = widget.apiService.getDeviceById(widget.deviceId);
    _deviceFuture.then((device) {
      setState(() {
        _device = device;
        _nameController.text = device.name;
        _categoryController.text = device.category;
        _descriptionController.text = device.description;
        _priceController.text = device.price.toString();
        _imageUrlController.text = device.imageUrl;
        _quantityController.text = device.quantity.toString();
      });
    });
  }

  void _updateDevice(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final updatedDevice = Device(
        id: _device.id,
        name: _nameController.text,
        category: _categoryController.text,
        description: _descriptionController.text,
        price: int.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        quantity: int.parse(_quantityController.text),
        isFavorite: _device.isFavorite,
      );

      try {
        await widget.apiService.updateDevice(updatedDevice);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Товар обновлен')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при обновлении товара: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать товар'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<Device>(
        future: _deviceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Нет данных'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Название'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите название';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _categoryController,
                        decoration: const InputDecoration(labelText: 'Категория'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите категорию';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(labelText: 'Описание'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите описание';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: 'Цена'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите цену';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: const InputDecoration(labelText: 'URL изображения'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите URL изображения';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _quantityController,
                        decoration: const InputDecoration(labelText: 'Количество'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите количество';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _updateDevice(context),
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
                            'Обновить товар',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
