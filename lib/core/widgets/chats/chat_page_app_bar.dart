import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class ChatPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  const ChatPageAppBar({super.key, required this.title, this.subtitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(color: MyColors.white, boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 4, offset: Offset(0, 2))]),
          child: Row(
            children: [
              InkWell(
                onTap: Get.back,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.arrow_back_ios, color: MyColors.textPrimary, size: 20,),
                ),
              ),
              const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: MyColors.grey,
                    child: Text(
                      title.isNotEmpty ? title[0] : '?',
                      style: const TextStyle(color: MyColors.textPrimary),
                    ),
                  ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: const TextStyle(color: MyColors.textPrimary, fontWeight: FontWeight.w700)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: const TextStyle(color: MyColors.textSecondary, fontSize: 12)),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
