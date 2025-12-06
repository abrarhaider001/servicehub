import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';
import 'package:servicehub/core/widgets/provider-info/chips_style.dart';
import 'package:servicehub/view_model/provider_info_controller.dart';
import 'package:servicehub/core/routes/app_routes.dart';

class ProviderInfoPage extends StatelessWidget {
  final String providerId;
  const ProviderInfoPage({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProviderInfoController(providerId: providerId));
    return ChatNow(c: c);
  }
}

class ChatNow extends StatelessWidget {
  const ChatNow({
    super.key,
    required this.c,
  });

  final ProviderInfoController c;

  @override
  Widget build(BuildContext context) {
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
        if (createdAt is Timestamp) {
        } else if (createdAt is String) {
        }
    
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
                          right: 0,
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
                            Expanded(child: Text(email, style: const TextStyle(color: MyColors.textPrimary))),
                          ],
                        ),
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
                  const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Work Details', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                  const SizedBox(height: 8),
                  Row(children: [const Icon(Icons.attach_money_rounded, color: MyColors.primary, size: 18), 
                  const SizedBox(width: 8), Expanded(child: Text('${hourly.toStringAsFixed(0)} / hr', style: const TextStyle(color: MyColors.textPrimary)))]),
                  const SizedBox(height: 8),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: const Icon(Icons.work_history_outlined, color: MyColors.primary, size: 14),
                    ), 
                  const SizedBox(width: 8), Expanded(child: Text('$expYears yrs experience', style: const TextStyle(color: MyColors.textPrimary)))]),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Summary', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                  const SizedBox(height: 8),
                  Text(summary, style: const TextStyle(color: MyColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Skills', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((s) => chip(s)).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Service Area', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: areas.map((s) => chip(s)).toList(),
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Get.toNamed(AppRoutes.home, parameters: {'tab': 'chat'}),
              child: const Text('Chat now', style: TextStyle(color: MyColors.white, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}
