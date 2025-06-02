import 'package:flutter/material.dart';
import 'package:yenimobilprojesi/screens/profile_screen.dart';
import 'package:yenimobilprojesi/screens/login_screen.dart';
import '../main.dart';

class DrawerMenu extends StatelessWidget {
  final String username;

  const DrawerMenu({super.key, required this.username});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: const Text(""),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            decoration: const BoxDecoration(color: Colors.deepPurple),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil"),
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
              Navigator.pop(context); // drawer'ı kapat
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Çıkış Yap"),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
