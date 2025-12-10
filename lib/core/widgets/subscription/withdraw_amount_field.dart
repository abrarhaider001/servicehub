import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';

class WithdrawAmountField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(double amount)? onChanged;
  const WithdrawAmountField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Withdraw amount', style: TextStyle(fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: MyTextFormFieldTheme.lightInputDecoration(
            hintText: 'Enter amount',
            prefixIcon: const Icon(Icons.attach_money, color: MyColors.primary),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (v) {
            final amt = double.tryParse(v.replaceAll(',', '').trim()) ?? 0.0;
            onChanged?.call(amt);
          },
          validator: (v) {
            final s = (v ?? '').trim();
            if (s.isEmpty) return 'Required';
            if (!RegExp(r'^\d+$').hasMatch(s)) return 'Digits only';
            if (int.tryParse(s) == null || (int.tryParse(s) ?? 0) <= 0) return 'Enter a valid amount';
            return null;
          },
        ),
      ],
    );
  }
}
