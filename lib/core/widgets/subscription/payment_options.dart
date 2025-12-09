import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class PaymentOptions extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  final List<String>? enabledValues;
  const PaymentOptions({
    super.key,
    required this.selected,
    required this.onChanged,
    this.enabledValues,
  });

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  Widget _tile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final selected = widget.selected == value;
    final enabled = widget.enabledValues == null || widget.enabledValues!.contains(value);
    return GestureDetector(
      onTap: enabled ? () => widget.onChanged(value) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? MyColors.grey10 : MyColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: enabled ? (selected ? MyColors.black : MyColors.grey10) : MyColors.grey10,
            width: selected ? 1 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: enabled ? MyColors.textPrimary : MyColors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: enabled ? MyColors.textPrimary : MyColors.grey),
              ),
            ),
            IgnorePointer(
              ignoring: !enabled,
              child: Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: enabled ? MyColors.textPrimary : MyColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _tile(
          icon: Icons.credit_card,
          label: 'Credit/Debit card',
          value: 'card',
        ),
        _tile(
          icon: Icons.account_balance_wallet_outlined,
          label: 'PayPal',
          value: 'paypal',
        ),
        _tile(icon: Icons.shop_2_outlined, label: 'Google Pay', value: 'gpay'),
        _tile(
          icon: Icons.currency_bitcoin_outlined,
          label: 'Binance coin',
          value: 'bnb',
        ),
      ],
    );
  }
}
