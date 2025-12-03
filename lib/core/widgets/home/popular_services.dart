import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';

class PopularServices extends StatelessWidget {
  const PopularServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final providers = [
            {
              'name': 'Ahmed Faruqi',
              'rating': '4.8 (1.2k)',
              'service': 'House cleaning',
              'price': 80,
            },
            {
              'name': 'Fahad Ali',
              'rating': '4.5 (980)',
              'service': 'Laundry & washing',
              'price': 65,
            },
            {
              'name': 'Hasan Ahmed',
              'rating': '4.6 (1.1k)',
              'service': 'Ironing service',
              'price': 70,
            },
            {
              'name': 'Mila Khan',
              'rating': '4.7 (900)',
              'service': 'Kitchen cleaning',
              'price': 75,
            },
            {
              'name': 'Rafiq Islam',
              'rating': '4.4 (820)',
              'service': 'Bathroom cleaning',
              'price': 60,
            },
            {
              'name': 'Sana Rahman',
              'rating': '4.9 (1.5k)',
              'service': 'Deep cleaning',
              'price': 90,
            },
          ];
          final it = providers[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MyColors.lightGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: MyColors.grey,
                  foregroundImage: AssetImage(MyImages.user),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  it['name'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${(it['price'] as num).toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '/hr',
                                style: TextStyle(
                                  color: MyColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        it['service'] as String,
                        style: const TextStyle(color: MyColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.star1,
                            color: MyColors.warning,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            it['rating'] as String,
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
          );
        },
      ),
    );
  }
}
