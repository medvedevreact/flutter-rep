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
        throw Exception('Ошибка при загрузке');
      }
    } catch (e) {
      throw Exception('Ошибка при загрузке: $e');
    }
  }
}
