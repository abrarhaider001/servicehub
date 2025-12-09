import 'package:flutter/material.dart';
import 'package:servicehub/core/widgets/child_profile_widgets/wallet/wallet_header.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/widgets/child_profile_widgets/wallet/transactions_list.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Wallet', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletHeader(
              balance: '\$54,8673.94',
              onDeposit: () => Get.toNamed(AppRoutes.deposit),
              onWithdraw: () => Get.toNamed(AppRoutes.withdraw),
            ),
            const SizedBox(height: 26),
            WalletTransactions(
              items: const [
                {'title': "Home cleaning", 'amountText': '-\$234.40', 'dateText': '08/10/2021', 'positive': false},
                {'title': 'Gardening', 'amountText': '-\$17.21', 'dateText': '08/10/2021', 'positive': false},
                {'title': 'Refrigrator maintenance', 'amountText': '-\$10.02', 'dateText': '08/08/2021', 'positive': false},
                {'title': 'Top-Up', 'amountText': '+\$2000.99', 'dateText': '08/07/2021', 'positive': true},
              ],
            ),
          ],
        ),
      ),
    );
  }
}
