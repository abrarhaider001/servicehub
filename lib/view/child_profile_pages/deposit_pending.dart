import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/widgets/custom_background.dart';

class DepositPendingPage extends StatefulWidget {
  const DepositPendingPage({super.key});

  @override
  State<DepositPendingPage> createState() => _DepositPendingPageState();
}

class _DepositPendingPageState extends State<DepositPendingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Iconsax.import, size: 64),
                SizedBox(height: 16),
                Text('Your transaction is in progress', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.primary)),
                SizedBox(height: 8),
                Text('Wait for approval, then you can login freely'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
