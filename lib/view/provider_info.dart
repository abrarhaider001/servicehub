import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';
import 'package:servicehub/view_model/provider_info_controller.dart';

class ProviderInfoPage extends StatelessWidget {
  final String providerId;
  const ProviderInfoPage({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProviderInfoController(providerId: providerId));
    return Scaffold(
      appBar: const CustomAppBar(title: 'Provider Info', showBack: true),
      body: Obx(() {
        if (c.loading.value) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        final p = c.provider.value ?? {};
        final u = c.user.value ?? {};
        final name = (p['displayName'] as String?) ?? (u['fullName'] as String?) ?? 'Provider';
        final rating = (p['ratingAvg'] as num?)?.toDouble() ?? 0;
        final ratingCount = (p['ratingCount'] as num?)?.toInt() ?? 0;
        final hourly = (p['hourlyRate'] as num?)?.toDouble() ?? 0;
        final expYears = (p['experienceYears'] as num?)?.toInt() ?? 0;
        final summary = (p['profileSummary'] as String?) ?? 'No summary';
        final skills = (p['skills'] as List?)?.cast<String>() ?? const <String>[];
        final areas = (p['serviceArea'] as List?)?.cast<String>() ?? const <String>[];
        final city = (u['city'] as String?) ?? 'Unknown';
        final email = (u['email'] as String?) ?? 'N/A';
        final online = (p['isOnline'] as bool?) ?? false;
        final createdAt = p['createdAt'] ?? u['createdAt'];
        DateTime? joined;
        if (createdAt is Timestamp) {
          joined = createdAt.toDate();
        } else if (createdAt is String) {
          joined = DateTime.tryParse(createdAt);
        }
        final joinedText = joined != null ? _formatDate(joined) : 'N/A';

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(radius: 28, backgroundColor: MyColors.grey, foregroundImage: AssetImage(MyImages.user)),
                      if (online)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(color: MyColors.success, shape: BoxShape.circle, border: Border.all(color: MyColors.white, width: 2)),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Iconsax.star1, color: MyColors.warning, size: 16),
                            const SizedBox(width: 4),
                            Text('${rating.toStringAsFixed(1)} ($ratingCount)', style: const TextStyle(color: MyColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\$${hourly.toStringAsFixed(0)} / hr', style: const TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                        const SizedBox(height: 4),
                        Text('$expYears yrs exp', style: const TextStyle(color: MyColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: MyColors.grey10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Contact', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                    const SizedBox(height: 8),
                    Row(children: [const Icon(Icons.email_outlined, color: MyColors.primary), const SizedBox(width: 8), Expanded(child: Text(email, style: const TextStyle(color: MyColors.textPrimary)))]),
                    const SizedBox(height: 8),
                    Row(children: [const Icon(Icons.calendar_today_outlined, color: MyColors.primary, size: 18), const SizedBox(width: 8), Expanded(child: Text('Joined $joinedText', style: const TextStyle(color: MyColors.textPrimary)))]),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: MyColors.lightGrey, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Summary', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text(summary, style: const TextStyle(color: MyColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Skills', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((s) => _chip(s)).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Service Area', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: areas.map((s) => _chip(s)).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Location', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: MyColors.lightGrey, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Iconsax.location, color: MyColors.primary),
                    const SizedBox(width: 8),
                    Expanded(child: Text(city, style: const TextStyle(color: MyColors.textPrimary))),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _chip(String label) {
    final text = label[0].toUpperCase() + label.substring(1).toLowerCase();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: MyColors.grey10)),
      child: Text(text, style: const TextStyle(color: MyColors.textSecondary)),
    );
  }

  String _formatDate(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final m = months[d.month - 1];
    return '$m ${d.day}, ${d.year}';
  }
}
