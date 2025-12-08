import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/child_profile_widgets/wallet/action_circle.dart';

class WalletHeader extends StatelessWidget {
  final String balance;
  final VoidCallback? onDeposit;
  final VoidCallback? onWithdraw;
  final VoidCallback? onAvailable;
  const WalletHeader({
    super.key,
    this.balance = '\$0.00',
    this.onDeposit,
    this.onWithdraw,
    this.onAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                balance,
                style: MyTextTheme.lightTextTheme.displayLarge!.copyWith(fontSize: 34),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionCircle(icon: Iconsax.import, label: 'Deposit', onTap: onDeposit),
              ActionCircle(icon: Iconsax.export, label: 'Withdraw', onTap: onWithdraw),
              ActionCircle(icon: Iconsax.eye, label: 'Available', onTap: onAvailable),
            ],
          ),
        ],
      ),
    );
  }
}

