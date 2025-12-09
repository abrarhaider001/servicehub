import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/subscription/payment_card_preview.dart';
import 'package:servicehub/core/widgets/subscription/card_form.dart';
import 'package:servicehub/core/widgets/subscription/deposit_amount_field.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _amountController = TextEditingController();
  final _depositFormKey = GlobalKey<FormState>();
  double _amount = 0.0;
  String _number = '';
  String _expiry = '';
  // ignore: unused_field
  String _cvv = '';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handleDeposit(String number, String expiry, String cvv) async {
    if (!(_depositFormKey.currentState?.validate() ?? false)) {
      return;
    }
    await Future.delayed(const Duration(seconds: 2));
    Get.toNamed(AppRoutes.pending, arguments: {
      'title': 'Deposit is processing',
      'subtitle': 'Please wait while we confirm your deposit',
    });
  }

  @override
  Widget build(BuildContext context) {
    final sanitized = _number.replaceAll(' ', '');
    final last4 = sanitized.length >= 4
        ? sanitized.substring(sanitized.length - 4)
        : '';
    return Scaffold(
      appBar: const CustomAppBar(title: 'Deposit', showBack: true),
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Please enter card information and deposit amount.',
                    textAlign: TextAlign.left,
                    style: MyTextTheme.lightTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  PaymentCardPreview(
                    amount: _amount,
                    last4: last4,
                    expiry: _expiry.isEmpty ? 'MM/YY' : _expiry,
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _depositFormKey,
                    child: DepositAmountField(
                      controller: _amountController,
                      onChanged: (amt) => setState(() => _amount = amt),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CardForm(
                    onProceed: _handleDeposit,
                    onChanged: (n, e, c) => setState(() {
                      _number = n;
                      _expiry = e;
                      _cvv = c;
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
