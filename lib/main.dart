import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SuHatirlaticiApp());
}

class SuHatirlaticiApp extends StatefulWidget {
  const SuHatirlaticiApp({super.key});

  @override
  State<SuHatirlaticiApp> createState() => _SuHatirlaticiAppState();

  static _SuHatirlaticiAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_SuHatirlaticiAppState>();
}

class _SuHatirlaticiAppState extends State<SuHatirlaticiApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Su Hatırlatıcısı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const LoginScreen(),
    );
  }
}
