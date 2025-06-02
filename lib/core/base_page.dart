import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'drawer_menu.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget content;
  final String username;

  const BasePage({
    super.key,
    required this.title,
    required this.content,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      drawer: DrawerMenu(username: username),
      body: content,
    );
  }
}
