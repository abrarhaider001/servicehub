import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/widgets/auth/auth_header.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/subscription/plans_grid.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  const AuthHeader(
                    title: 'Choose Your Plan',
                    subtitle: 'Please select the plan that best fits your needs',
                  ),
                  const SizedBox(height: 36),
                  PlansGrid(
                    onSelect: (planId, name, price, durationDays) {
                      Get.toNamed(AppRoutes.cardInfo, arguments: {
                        'planId': planId,
                        'name': name,
                        'price': price,
                        'durationDays': durationDays,
                      });
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



