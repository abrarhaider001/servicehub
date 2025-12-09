import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/view_model/providers_controller.dart';

class PopularServices extends StatelessWidget {
  const PopularServices({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProvidersController());
    return Expanded(
      child: Obx(() {
        if (controller.loading.value) {
          return ListView.separated(
            itemCount: 6,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, _) => const _ProviderSkeleton(),
          );
        }
        final items = controller.providers;
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final it = items[i];
            final name = it['displayName'] as String? ?? 'Unknown';
            final price = (it['hourlyRate'] as num?)?.toDouble() ?? 0;
            final rating = (it['ratingAvg'] as num?)?.toDouble() ?? 0;
            final summary =
                it['profileSummary'] as String? ??
                (it['skills'] is List
                    ? (it['skills'] as List).join(', ')
                    : 'Service');
            final pid = it['id'] as String?;
            return InkWell(
              onTap: () {
                if (pid != null && pid.isNotEmpty) {
                  Get.toNamed(AppRoutes.providerInfo, parameters: {'id': pid});
                } else {
                  Get.snackbar('Unavailable', 'Provider details not available');
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
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
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.textPrimary,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${price.toStringAsFixed(0)}',
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
                            summary,
                            style: const TextStyle(
                              color: MyColors.textSecondary,
                            ),
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
                                rating.toStringAsFixed(1),
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
              ),
            );
          },
        );
      }),
    );
  }
}

class _ProviderSkeleton extends StatelessWidget {
  const _ProviderSkeleton();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: MyColors.grey10,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 160, color: MyColors.grey10),
                const SizedBox(height: 8),
                Container(height: 12, width: 220, color: MyColors.grey10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
