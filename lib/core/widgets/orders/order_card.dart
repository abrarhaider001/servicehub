import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';

class OrderCard extends StatelessWidget {
  final String name;
  final String rating;
  final String service;
  final String est;
  final double price;
  final VoidCallback? onTap;
  const OrderCard({
    super.key,
    required this.name,
    required this.rating,
    required this.service,
    required this.est,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: MyColors.grey,
                  foregroundImage: AssetImage(MyImages.user),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: MyColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.star1,
                            color: MyColors.warning,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: const TextStyle(
                              color: MyColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: MyColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        est,
                        style: const TextStyle(
                          color: MyColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                 Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Check status',
                    style: TextStyle(
                      color: MyColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
             
              ],
            ),
          ],
        ),
      ),
    );
  }
}
