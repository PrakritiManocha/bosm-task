import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roulette2023/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.grey.shade900,
      ),
      home: const LoginPage(),
    );
  }
}
