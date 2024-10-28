import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/like_page.dart';
import '../models/device.dart';
import '../pages/profile_page.dart';
import '../models/profile.dart';
import '../pages/cart_page.dart';
import '../models/cart_item.dart';

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

  final List<Device> devices = [
    Device(1, 'Portable Bluetooth Speaker', 8, 'Speakers', 'JBL Flip 6',
        12999, 'https://m.media-amazon.com/images/I/71DMsp+X-pL._AC_SX355_.jpg', false),
    Device(2, 'Noise Cancelling Headphones', 5, 'Headphones', 'Sony WH-1000XM5',
        29999, 'https://m.media-amazon.com/images/I/61eeHPRFQ9L._AC_SX466_.jpg', false),
    Device(3, 'Smartwatch with GPS', 12, 'Wearables', 'Apple Watch Series 8',
        39999, 'https://m.media-amazon.com/images/I/71ulah9iIwL.__AC_SY445_SX342_QL70_FMwebp_.jpg', false),
    Device(4, 'Wireless Earbuds with Charging Case', 20, 'Earbuds', 'Samsung Galaxy Buds Pro',
        19999, 'https://m.media-amazon.com/images/I/712wbf6XxYL._AC_SL1500_.jpg', false),
    Device(5, '4K Ultra HD Smart TV', 3, 'TVs', 'LG OLED C1 Series',
        99999, 'https://m.media-amazon.com/images/I/91EBhKZOkEL._AC_SL1500_.jpg', false),
  ];

  final Profile profile = Profile(
    name: 'Медведев Иван Александрович',
    email: 'vanya.medvedev.20@mail.ru',
    phone: 'ЭФБО-01-22',
  );

  final List<CartItemModel> cartItems = [];

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
      LikePage(favoriteDevices: favoriteDevices, addToCart: addToCart),
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
