import 'package:flutter/material.dart';
import 'package:praktikum_5/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true, // Tambahan jika ingin menggunakan Material 3
        primarySwatch: Colors.amber,
        fontFamily: 'Roboto', // Tambahan Font Kustom
      ),
      home: const HomeScreen(), // HomeScreen dengan const
    );
  }
}
