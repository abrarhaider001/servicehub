import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class PlanCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final double price;
  final double? oldPrice;
  final int durationDays;
  final List<String> benefits;
  final bool included;
  final bool highlight;
  final VoidCallback onSelect;
  final bool selected;
  const PlanCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    this.oldPrice,
    required this.durationDays,
    required this.benefits,
    this.included = true,
    this.highlight = false,
    required this.onSelect,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MyColors.primary, MyColors.primary],
    );
    final titleStyle = TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 20,
      color: highlight ? Colors.white : MyColors.textPrimary,
      fontWeight: FontWeight.bold,
    );
    final subtitleStyle = TextStyle(
      fontSize: 13,
      color: highlight ? Colors.white70 : MyColors.textSecondary,
    );
    final priceStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: highlight ? Colors.white : MyColors.textPrimary,
    );
    final oldPriceStyle = TextStyle(
      fontSize: 14,
      color: highlight ? Colors.white54 : MyColors.textSecondary,
      decoration: TextDecoration.lineThrough,
    );

    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: highlight ? null : MyColors.white,
          gradient: highlight ? bgGradient : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? MyColors.primary : MyColors.primary, width: 2),
          boxShadow: const [
            BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.emoji_events, color: highlight ? Colors.white : MyColors.textPrimary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: titleStyle),
                      const SizedBox(height: 2),
                      Text(subtitle, style: subtitleStyle),
                    ],
                  ),
                ),
                if (included)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: highlight ? Colors.white24 : MyColors.grey10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Included', style: TextStyle(color: highlight ? Colors.white : MyColors.textPrimary, fontSize: 12)),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$ ${price.toStringAsFixed(2)}', style: priceStyle),
                    if (oldPrice != null) Text('\$ ${oldPrice!.toStringAsFixed(2)}', style: oldPriceStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Features', style: TextStyle(color: highlight ? Colors.white : MyColors.textPrimary, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...benefits.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: highlight ? Colors.white : MyColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(b, style: TextStyle(color: highlight ? Colors.white : MyColors.textPrimary))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
