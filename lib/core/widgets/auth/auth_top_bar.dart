import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTopBar extends StatelessWidget {
  final bool showBack;
  final VoidCallback? onBack;
  const AuthTopBar({super.key, this.showBack = true, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          IconButton(
            onPressed: onBack ?? Get.back,
            icon: const Icon(Icons.arrow_back),
          ),
      ],
    );
  }
}

