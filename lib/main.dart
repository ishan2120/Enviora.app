import 'package:flutter/material.dart';
import 'pages/language_selection_page.dart';

void main() {
  runApp(const EnvioraApp());
}

class EnvioraApp extends StatefulWidget {
  const EnvioraApp({super.key});

  @override
  State<EnvioraApp> createState() => _EnvioraAppState();
}

class _EnvioraAppState extends State<EnvioraApp> {
  Locale _locale = const Locale('en');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enviora',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('si'),
        Locale('ta'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: LanguageSelectionPage(onLanguageSelected: _setLocale),
    );
  }
}
