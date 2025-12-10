
import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String? description;
  final String amountText;
  final String dateText;
  final bool positive;
  const TransactionTile({super.key, required this.title, this.description, required this.amountText, required this.dateText, required this.positive});

  @override
  Widget build(BuildContext context) {
    final color = positive ? MyColors.success : MyColors.red;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(width: 2, height: 20, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: MyColors.textPrimary)),
                // const SizedBox(height: 4),
                if ((description ?? '').isNotEmpty) ...[
                  Text(description!, style: const TextStyle(color: MyColors.textPrimary, fontSize: 12)),
                  const SizedBox(height: 4),
                ],
                Text(dateText, style: const TextStyle(color: MyColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(amountText, style: MyTextTheme.lightTextTheme.displayLarge!.copyWith(fontSize: 14, color: color)),
        ],
      ),
    );
  }
}
