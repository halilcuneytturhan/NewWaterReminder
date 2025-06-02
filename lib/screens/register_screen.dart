import 'package:flutter/material.dart';
import '../db/user_db.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dailyGoalController = TextEditingController();

  Future<void> _register() async {
    print("Kayıt butonuna basıldı");

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    double? dailyGoal = double.tryParse(_dailyGoalController.text.trim());

    if (username.isEmpty || password.isEmpty || dailyGoal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tüm alanları eksiksiz doldur.")),
      );
      return;
    }

    final user = UserModel(
      username: username,
      password: password,
      dailyGoal: dailyGoal,
    );

    try {
      await UserDB.instance.insertUser(user);
      print("Kullanıcı veritabanına eklendi");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kayıt başarılı!")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print("HATA: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kayıt sırasında hata oluştu.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kayıt Ol")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              'Hesap Oluştur',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Kullanıcı Adı",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dailyGoalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Günlük Su Hedefi (litre)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _register, child: const Text("Kayıt Ol")),
          ],
        ),
      ),
    );
  }
}
