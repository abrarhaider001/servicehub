import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/child_profile_widgets/wallet/transaction_tile.dart';

class WalletTransactions extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final VoidCallback? onViewAll;
  const WalletTransactions({super.key, required this.items, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Recent transactions', style: MyTextTheme.lightTextTheme.headlineMedium!.copyWith(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((it) => TransactionTile(
                  title: it['title'] as String,
                  amountText: it['amountText'] as String,
                  dateText: it['dateText'] as String,
                  positive: (it['positive'] as bool?) ?? false,
                )),
          ],
        ),
      ),
    );
  }
}

