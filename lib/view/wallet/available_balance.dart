import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/main/orders/order_card.dart';

class AvailableBalancePage extends StatelessWidget {
  const AvailableBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ongoing = const [
      {
        'name': 'James Carter',
        'rating': '4.9',
        'service': 'Deep cleaning',
        'est': 'ETA: 2h',
        'price': 120.0,
      },
      {
        'name': 'Aria Blake',
        'rating': '4.7',
        'service': 'Garden care',
        'est': 'ETA: 1h',
        'price': 75.0,
      },
      {
        'name': 'Leo Martin',
        'rating': '4.8',
        'service': 'AC maintenance',
        'est': 'ETA: 3h',
        'price': 210.0,
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Available Balance', showBack: true),
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        '\$4,807.94',
                        style: MyTextTheme.lightTextTheme.displayLarge!
                            .copyWith(fontSize: 34),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: MyColors.grey10,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MyColors.grey10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: MyColors.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'This balance is withdrawable only. It is not involved in any ongoing orders or holds.',
                            style: MyTextTheme.lightTextTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ongoing orders',
                          style: MyTextTheme.lightTextTheme.headlineMedium!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    itemCount: ongoing.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final it = ongoing[i];
                      return OrderCard(
                        name: it['name'] as String,
                        rating: it['rating'] as String,
                        service: it['service'] as String,
                        est: it['est'] as String,
                        price: (it['price'] as num).toDouble(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
