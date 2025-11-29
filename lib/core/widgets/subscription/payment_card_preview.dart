import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class PaymentCardPreview extends StatelessWidget {
  final double amount;
  final String last4;
  final String expiry;
  final String brand;
  const PaymentCardPreview({
    super.key,
    required this.amount,
    required this.last4,
    required this.expiry,
    this.brand = 'VISA',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            amount.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('**** $last4', style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Exp. $expiry', style: const TextStyle(color: Colors.white54)),
              const Spacer(),
              Text(brand, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

