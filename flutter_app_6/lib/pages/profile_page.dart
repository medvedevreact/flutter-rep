import 'package:flutter/material.dart';
import '../models/product.dart';
import '../pages/edit_page.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  const ProfilePage({super.key, required this.profile});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Profile _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.profile;
  }

  void _editProfile(BuildContext context) async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(profile: _profile),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        _profile = updatedProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Профиль",
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFECEFF1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Colors.teal,
                    width: 4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _profile.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _profile.email,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _profile.phone,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _editProfile(context),
                child: const Text('Редактировать профиль'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
