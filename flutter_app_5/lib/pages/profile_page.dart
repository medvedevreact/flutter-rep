import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Профиль",
            style: TextStyle(
              fontSize: 24.0, // Уменьшил размер текста
            ),
          ),
        ),
        backgroundColor: Colors.teal, // Цвет приложения
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFECEFF1), // Светлый фон
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Центрирование содержимого
            children: [
              const SizedBox(height: 20),
              Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://avatars.githubusercontent.com/u/162450917?v=4',
                    ),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.teal, // Изменен цвет обводки на Colors.teal
                    width: 4, // Увеличил ширину границы
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Медведев Иван Александрович',
                style: TextStyle(
                  fontSize: 24.0, // Уменьшил размер текста
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'ЭФБО-01-22',
                style: TextStyle(
                  fontSize: 20.0, // Уменьшил размер текста
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'vanya.medvedev.20@mail.ru',
                style: TextStyle(
                  fontSize: 18.0, // Уменьшил размер текста
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
