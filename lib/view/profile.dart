import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.textPrimary),
      ),
    );
  }
}

