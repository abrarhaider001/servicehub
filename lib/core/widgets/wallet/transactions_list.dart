import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/wallet/transaction_tile.dart';

class WalletTransactions extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final VoidCallback? onViewAll;
  const WalletTransactions({super.key, required this.items, this.onViewAll});

  @override
  State<WalletTransactions> createState() => _WalletTransactionsState();
}

class _WalletTransactionsState extends State<WalletTransactions> {
  final ScrollController _controller = ScrollController();

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
            Expanded(
              child: ScrollbarTheme(
                data: const ScrollbarThemeData(
                  thumbColor: MaterialStatePropertyAll(MyColors.black),
                  thickness: MaterialStatePropertyAll(4),
                  radius: Radius.circular(8),
                ),
                child: ListView.separated(
                  controller: _controller,
                  primary: false,
                  itemCount: widget.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 0),
                  itemBuilder: (_, i) {
                    final it = widget.items[i];
                    return TransactionTile(
                      title: it['title'] as String,
                      description: it['description'] as String?,
                      amountText: it['amountText'] as String,
                      dateText: it['dateText'] as String,
                      positive: (it['positive'] as bool?) ?? false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

