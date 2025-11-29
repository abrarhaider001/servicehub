import 'package:flutter/material.dart';
import 'package:servicehub/core/widgets/custom_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          CustomBackground(),
          Center(child: Text('Welcome to ServiceHub', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

