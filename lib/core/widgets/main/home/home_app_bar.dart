
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final h = DateTime.now().hour;
    final greet = h < 12
        ? 'Morning!'
        : h < 17
            ? 'Afternoon!'
            : h < 21
                ? 'Evening!'
                : 'Night!';
    return Row(
      children: [
        const CircleAvatar(radius: 20, backgroundColor: MyColors.grey, foregroundImage: AssetImage(MyImages.user)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greet, style: const TextStyle(fontSize: 12, color: MyColors.textSecondary)),
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(20)),
          child: const Icon(Iconsax.setting_2, color: MyColors.primary),
        ),
      ],
    );
  }
}
