import 'package:flutter/material.dart';
import '../db/user_db.dart';
import '../models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dailyGoalController = TextEditingController();
  int? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final users = await UserDB.instance.getUsers();
    if (users.isNotEmpty) {
      final user = users.first;
      _userId = user.id;
      _usernameController.text = user.username;
      _passwordController.text = user.password;
      _dailyGoalController.text = user.dailyGoal.toString();
    }
  }

  Future<void> _updateUser() async {
    if (_userId == null) return;

    final updatedUser = UserModel(
      id: _userId,
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      dailyGoal: double.tryParse(_dailyGoalController.text.trim()) ?? 2.5,
    );

    await UserDB.instance.updateUser(updatedUser);

    if (!mounted) return;
    Navigator.pop(
      context,
      true,
    ); // 🔥 geri dönerken güncellendi bilgisini gönder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profili Güncelle")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Kullanıcı Adı"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Şifre"),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dailyGoalController,
              decoration: const InputDecoration(labelText: "Günlük Hedef (L)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _updateUser, child: const Text("Kaydet")),
          ],
        ),
      ),
    );
  }
}
