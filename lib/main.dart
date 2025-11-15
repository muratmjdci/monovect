import 'package:flutter/material.dart';
import 'package:monovect/features/home/presentation/home_view.dart';
import 'package:monovect/features/paywall/presentation/paywall_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vectorify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        fontFamily: 'Inter',
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFC6F54C),
          secondary: const Color(0xFF00FFC3),
          surface: const Color(0xFF1E1E1E).withOpacity(0.45),
        ),
      ),
      home: HomeView(),
    );
  }
}
