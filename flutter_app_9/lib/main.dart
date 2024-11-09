import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/like_page.dart';
import '../models/device.dart';
import '../pages/profile_page.dart';
import '../models/profile.dart';
import '../pages/cart_page.dart';
import '../models/cart_item.dart';
import '../api/instance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  List<Device> devices = [];
  final Profile profile = Profile(
    name: 'Медведев Иван Александрович',
    email: 'vanya.medvedev.20@mail.ru',
    phone: 'ЭФБО-01-22',
  );
  final List<CartItemModel> cartItems = [];
  final ApiService apiService = ApiService(); // Добавьте apiService

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  Future<void> _fetchDevices() async {
    try {
      final fetchedDevices = await apiService.fetchDevices();
      setState(() {
        devices = fetchedDevices;
      });
    } catch (e) {
      print('Error fetching devices: $e');
    }
  }

  void onItemTapped(int i) {
    setState(() {
      index = i;
    });
  }

  void addToCart(Device device) {
    setState(() {
      var existingItem = cartItems.firstWhere(
            (item) => item.id == device.id,
        orElse: () => CartItemModel(id: device.id, name: device.name, price: device.price, count: 0),
      );
      existingItem.count++;
      if (existingItem.count == 1) {
        cartItems.add(existingItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Device> favoriteDevices =
    devices.where((device) => device.isFavorite).toList();

    final List<Widget> _pages = [
      HomePage(devices: devices, addToCart: addToCart),
      LikePage(favoriteDevices: favoriteDevices, addToCart: addToCart, apiService: apiService), // Передайте apiService
      ProfilePage(profile: profile),
      CartPage(items: cartItems),
    ];

    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 231, 143, 12),
        unselectedItemColor: const Color.fromARGB(255, 164, 164, 164),
      ),
    );
  }
}
