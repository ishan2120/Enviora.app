import 'package:flutter/material.dart';

/// Placeholder HomeScreen — replace this with your actual dashboard widget
/// once the screen content is ready. The [mobile_app/lib/main.dart] references
/// this class as the entry point of the mobile_app sub-project.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Enviora',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
