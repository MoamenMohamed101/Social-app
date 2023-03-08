import 'package:flutter/material.dart';
import 'package:social_app/modules/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
       // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SocialLoginScreen()
    );
  }
}
