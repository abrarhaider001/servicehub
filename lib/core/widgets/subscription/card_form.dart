import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';

class CardForm extends StatefulWidget {
  final Future<void> Function(String number, String expiry, String cvv) onProceed;
  final void Function(String number, String expiry, String cvv)? onChanged;
  final double? planPrice;
  const CardForm({super.key, required this.onProceed, this.onChanged, this.planPrice});

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  final _holder = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _number.dispose();
    _expiry.dispose();
    _cvv.dispose();
    _holder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _holder,
            textInputAction: TextInputAction.next,
            decoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: 'Card Holder Name',
              prefixIcon: const Icon(Icons.person_outline, color: MyColors.primary),
            ),
            onChanged: (v) => widget.onChanged?.call(_number.text, _expiry.text, _cvv.text),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _number,
            keyboardType: TextInputType.number,
            decoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: 'Card Number',
              prefixIcon: const Icon(Icons.credit_card, color: MyColors.primary),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
              _CardNumberInputFormatter(),
            ],
            onChanged: (v) => widget.onChanged?.call(_number.text, _expiry.text, _cvv.text),
            validator: (v) => _validateCardNumber(v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiry,
                  keyboardType: TextInputType.datetime,
                  decoration: MyTextFormFieldTheme.lightInputDecoration(
                    hintText: 'MM/YY',
                    prefixIcon: const Icon(Icons.event, color: MyColors.primary),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    _ExpiryDateInputFormatter(),
                  ],
                  onChanged: (v) => widget.onChanged?.call(_number.text, _expiry.text, _cvv.text),
                  validator: (v) => _validateExpiry(v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _cvv,
                  keyboardType: TextInputType.number,
                  decoration: MyTextFormFieldTheme.lightInputDecoration(
                    hintText: 'CVV',
                    prefixIcon: const Icon(Icons.lock_outline, color: MyColors.primary),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (v) => widget.onChanged?.call(_number.text, _expiry.text, _cvv.text),
                  validator: (v) {
                    final s = v ?? '';
                    if (s.isEmpty) return 'Required';
                    final ok = RegExp(r'^\d{3,4}$').hasMatch(s);
                    return ok ? null : 'Invalid CVV';
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (widget.planPrice != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: MyColors.grey10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long, color: MyColors.primary),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Plan price', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Text('\$ ${widget.planPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: MyColors.textPrimary)),
                ],
              ),
            ),
          const SizedBox(height: 16),
          GradientElevatedButton(
            onPressed: _loading
                ? null
                : () async {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    setState(() => _loading = true);
                    final sanitizedNumber = _number.text.replaceAll(' ', '');
                    await widget.onProceed(sanitizedNumber, _expiry.text, _cvv.text);
                    setState(() => _loading = false);
                  },
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : Text('Proceed', style: MyTextTheme.lightTextTheme.titleLarge?.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

extension on _CardFormState {
  String? _validateCardNumber(String? v) {
    final s = (v ?? '').replaceAll(' ', '');
    if (s.isEmpty) return 'Required';
    if (!RegExp(r'^\d+$').hasMatch(s)) return 'Invalid card number';
    if (s.length < 12) return 'Must be at least 12 digits';
    return null;
  }

  String? _validateExpiry(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Required';
    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(s)) return 'Invalid format';
    final parts = s.split('/');
    final month = int.tryParse(parts[0]) ?? 0;
    final year = 2000 + (int.tryParse(parts[1]) ?? 0);
    if (month < 1 || month > 12) return 'Invalid month';
    final now = DateTime.now();
    final nowYm = now.year * 100 + now.month;
    final expYm = year * 100 + month;
    if (expYm < nowYm) return 'Expired card';
    return null;
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final isEndOfGroup = (i + 1) % 4 == 0 && i + 1 != digits.length;
      if (isEndOfGroup) buffer.write(' ');
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 4) digits = digits.substring(0, 4);
    String formatted;
    if (digits.length <= 2) {
      formatted = digits;
    } else {
      formatted = digits.substring(0, 2) + '/' + digits.substring(2);
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
