import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:lottie/lottie.dart';

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
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: Lottie.asset(
                    'assets/animations/success.json',
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('You are all setup!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.primary)),
                const SizedBox(height: 8),
                const Text('your transaction is processing and will be completed shortly', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
