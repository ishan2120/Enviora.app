import 'package:flutter/material.dart';
import 'profile_screen.dart';

void main() {
  runApp(const EnvioraApp());
}

class EnvioraApp extends StatelessWidget {
  const EnvioraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enviora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray background
        useMaterial3: true,
        fontFamily: 'Roboto', // Using default sans-serif, would use a custom font if assets provided
      ),
      home: const ProfileScreen(),
    );
  }
}
