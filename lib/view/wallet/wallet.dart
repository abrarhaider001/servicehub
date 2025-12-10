import 'package:flutter/material.dart';
import 'package:servicehub/core/widgets/wallet/wallet_header.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/widgets/wallet/transactions_list.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/view_model/wallet_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late final WalletController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(WalletController());
    _controller.refreshBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Wallet',
        showBack: true,
        onBack: () => Get.offNamed(AppRoutes.home, parameters: {'index': '3'}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => WalletHeader(
                  balance: '\$${_controller.balance.value.toStringAsFixed(2)}',
                  onDeposit: () => Get.toNamed(AppRoutes.deposit),
                  onWithdraw: () => Get.toNamed(AppRoutes.withdraw),
                  onAvailable: () => Get.toNamed(AppRoutes.available),
                )),
            const SizedBox(height: 26),
            Obx(() {
              final items = _controller.history;
              final _ = items.length;
              return WalletTransactions(items: items.toList());
            }),
          ],
        ),
      ),
    );
  }
}
