import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chats',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.textPrimary),
      ),
    );
  }
}

