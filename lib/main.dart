import 'package:flutter/material.dart';
import 'package:sehatyuk/ProfilePage.dart';
import 'package:sehatyuk/welcome.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF4A707A),
          secondary: Color(0xFFC2C8C5),
          tertiary: Color(0xFF94B0B7),
          onPrimary: Color(0xFF37363B)
        ),
        fontFamily: 'Poppins'
      ),
    );
  }
}

mixin AppMixin{
  FontWeight bold = FontWeight.w700;
  FontWeight semi = FontWeight.w600;
  double sideMargin = 20;
}