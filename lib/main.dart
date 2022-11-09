import 'package:flutter/material.dart';
import 'package:flutter_inventory/theme/in_theme.dart';

import 'features/inventories/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: InTheme.theme(context),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
