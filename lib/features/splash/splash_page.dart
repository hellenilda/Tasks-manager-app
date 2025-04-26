import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Color.fromARGB(255, 255, 167, 211),
            Color.fromARGB(255, 255, 130, 192)
            ])
        ),
        child: const Text('Financy', style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w700, color: Color(0xFFFFFFFF))),
      ),
    );
  }
}