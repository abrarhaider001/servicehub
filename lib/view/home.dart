import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to ServiceHub',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.textPrimary),
      ),
    );
  }
}

