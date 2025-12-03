import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

Widget detailTile(IconData icon, String value, String label) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: MyColors.lightGrey, borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Icon(icon, color: MyColors.textPrimary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(color: MyColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}