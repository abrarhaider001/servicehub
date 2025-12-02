
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';

class ProfileAppBar extends StatelessWidget {
  final String title;
  final bool showBack;
  final bool showTrailing;

  const ProfileAppBar({
    required this.title,
    this.showBack = true,
    this.showTrailing = true,
    super.key,
  });


  @override
Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          if (showBack)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Iconsax.arrow_left, color: MyColors.primary),
            ),
          Expanded(
            child: Text(title, textAlign: TextAlign.left, style: MyTextTheme.lightTextTheme.displayMedium),
          ),
          if (showTrailing)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Iconsax.notification, color: MyColors.primary),
            ),
        ],
      ),
    );
  }
}
