import 'package:flutter/material.dart';
import 'package:mobile/features/home/home_page.dart';

void main() {
  runApp(const RemoteOpsApp());
}

class RemoteOpsApp extends StatelessWidget {
  const RemoteOpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RemoteOps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2A2A2A),
          foregroundColor: Colors.white,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
