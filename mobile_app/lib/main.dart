import 'package:flutter/material.dart';
import 'screens/home/dashboard.dart';

void main() {
  runApp(const Enviora());
}

class Enviora extends StatelessWidget {
  const Enviora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enviora',
      theme: ThemeData(
        fontFamily: 'SF Pro',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}