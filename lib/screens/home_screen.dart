import 'package:flutter/material.dart';
import 'dart:async';
import '../db/user_db.dart';
import '../models/user_model.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _user;
  Timer? _timer;
  int _remainingSeconds = 64800; // 18 saat = 64800 saniye

  @override
  void initState() {
    super.initState();
    _loadUser();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {});
        _timer?.cancel();
      }
    });
  }

  Future<void> _loadUser() async {
    final users = await UserDB.instance.getUsers();
    if (users.isNotEmpty) {
      setState(() {
        _user = users.first;
      });
    }
  }

  Future<void> _incrementWater() async {
    if (_user == null) return;

    double newAmount = _user!.consumedWater + 0.25;
    await UserDB.instance.updateConsumedWater(_user!.id!, newAmount);
    await _loadUser();

    if (_user != null && _user!.consumedWater >= _user!.dailyGoal) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 Günlük hedefini tamamladın! Tebrikler!"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    double remaining = (_user!.dailyGoal - _user!.consumedWater).clamp(
      0,
      _user!.dailyGoal,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Güncel İçilmiş Su Takip")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menü',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profilim"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text("Tema Değiştir"),
              onTap: () {
                SuHatirlaticiApp.of(context)?.toggleTheme();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Çıkış Yap"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.network(
              'https://image.winudf.com/v2/image1/Y29tLndhbmd3ZWkucmVtaW5kZXJtZXRvZHJpbmt3YXRlci5oeWRyYXRpb25hcHBfc2NyZWVuXzBfMTYwNjI0MTg1OF8wNjY/screen-0.jpg?fakeurl=1&type=.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  "Bugünkü Durumun",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _infoCard("🎯 Günlük Hedef 🎯", "${_user!.dailyGoal} L"),
                _infoCard("💧İçilen Su💧", "${_user!.consumedWater} L"),
                _infoCard("💧Kalan💧", "$remaining L"),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _incrementWater,
                  child: const Text("+0.25 L içtim"),
                ),
                const SizedBox(height: 24),
                Text(
                  _remainingSeconds > 0
                      ? "Kalan Süre: ${_formatTime(_remainingSeconds)}"
                      : "⏰ Gün bitti!",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
