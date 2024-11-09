import 'package:dio/dio.dart';
import '../models/device.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Device>> fetchDevices() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8080/devices');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Device> devices = data.map((item) => Device.fromJson(item)).toList();
        return devices;
      } else {
        throw Exception('Не удалось загрузить устройства');
      }
    } catch (e) {
      throw Exception('Не удалось загрузить устройства: $e');
    }
  }

  Future<void> addDevice(Device device) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/devices/create',
        data: device.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Не удалось добавить устройство');
      }
    } catch (e) {
      throw Exception('Не удалось добавить устройство: $e');
    }
  }

  Future<void> deleteDevice(int id) async {
    try {
      final response = await _dio.delete('http://10.0.2.2:8080/devices/delete/$id');
      if (response.statusCode != 200) {
        throw Exception('Не удалось удалить устройство');
      }
    } catch (e) {
      throw Exception('Не удалось удалить устройство: $e');
    }
  }

  Future<Device> getDeviceById(int id) async {
    try {
      final response = await _dio.get('http://10.0.2.2:8080/devices/$id');
      if (response.statusCode == 200) {
        return Device.fromJson(response.data);
      } else {
        throw Exception('Не удалось загрузить устройство');
      }
    } catch (e) {
      throw Exception('Не удалось загрузить устройство: $e');
    }
  }

  Future<void> updateDevice(Device device) async {
    try {
      final response = await _dio.put(
        'http://10.0.2.2:8080/devices/update/${device.id}',
        data: device.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Не удалось обновить устройство');
      }
    } catch (e) {
      throw Exception('Не удалось обновить устройство: $e');
    }
  }
}
