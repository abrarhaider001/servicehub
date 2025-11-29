import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/widgets/custom_background.dart';

class TransactionPendingPage extends StatefulWidget {
  const TransactionPendingPage({super.key});

  @override
  State<TransactionPendingPage> createState() => _TransactionPendingPageState();
}

class _TransactionPendingPageState extends State<TransactionPendingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 20), () {
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
                Icon(Icons.hourglass_bottom, size: 64),
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
