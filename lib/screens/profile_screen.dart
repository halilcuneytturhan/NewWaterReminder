import 'package:flutter/material.dart';
import '../db/user_db.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final users = await UserDB.instance.getUsers();
    if (users.isNotEmpty) {
      setState(() {
        _user = users.first;
      });
    }
  }

  Future<void> _deleteUser() async {
    if (_user != null) {
      await UserDB.instance.deleteUserById(_user!.id!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kullanıcı silindi.")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _editUser() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
    if (updated == true) {
      await _loadUser(); // Güncel kullanıcı bilgilerini tekrar yükle
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body:
          _user == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2014/12/24/05/02/drop-of-water-578897_1280.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Kullanıcı Bilgileri",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "👤 Kullanıcı Adı: ${_user!.username}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "🎯 Günlük Su Hedefi: ${_user!.dailyGoal} L",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _editUser,
                                icon: const Icon(Icons.edit),
                                label: const Text("Profili Düzenle"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _deleteUser,
                                icon: const Icon(Icons.delete_forever),
                                label: const Text("Hesabımı Sil"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
