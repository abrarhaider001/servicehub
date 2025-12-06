  import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

Widget chip(String label) {
    final text = label[0].toUpperCase() + label.substring(1).toLowerCase();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: MyColors.grey10)),
      child: Text(text, style: const TextStyle(color: MyColors.textSecondary)),
    );
  }