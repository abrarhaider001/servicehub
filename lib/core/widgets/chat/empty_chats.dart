import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class EmptyChats extends StatelessWidget {
  const EmptyChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Iconsax.message, color: MyColors.grey, size: 48),
        SizedBox(height: 12),
        Text('No conversations yet', style: TextStyle(color: MyColors.textSecondary)),
        SizedBox(height: 32),
      ],
    );
  }
}
