import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class CardPreview extends StatelessWidget {
  final double amount;
  final String last4;
  final String brand;
  final String expiry;
  const CardPreview({
    super.key,
    required this.amount,
    required this.last4,
    required this.brand,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: MyColors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, 8)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: Text(
              '24 ${amount.toStringAsFixed(1)}',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 44,
            child: Text(
              '**** $last4',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 20,
            child: Text(
              'Exp. $expiry',
              style: const TextStyle(color: Colors.white60),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 16,
            child: Text(
              brand.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

