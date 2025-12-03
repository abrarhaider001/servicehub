import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class Category extends StatelessWidget {
  final IconData icon;
  final String label;
  const Category({super.key, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(color: MyColors.primary, borderRadius: BorderRadius.circular(32)),
          child: Icon(icon, color: MyColors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: MyColors.textSecondary)),
      ],
    );
  }
}
