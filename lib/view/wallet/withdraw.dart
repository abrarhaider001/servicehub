import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/subscription/deposit_amount_field.dart';
import 'package:servicehub/core/widgets/subscription/payment_options.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  double _amount = 0.0;
  String _method = 'card';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _confirmWithdraw() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_amount <= 0) return;
    Get.toNamed(AppRoutes.pending, arguments: {
      'title': 'Withdraw is processing',
      'subtitle': 'Please wait while we process your withdrawal',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Withdraw', showBack: true),
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
                    'Please select the withdrawal method, and enter the amount.',
                    textAlign: TextAlign.left,
                    style: MyTextTheme.lightTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: DepositAmountField(
                      controller: _amountController,
                      onChanged: (amt) => setState(() => _amount = amt),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Withdraw method',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: MyColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PaymentOptions(
                    selected: _method,
                    onChanged: (v) => setState(() => _method = v),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: GradientElevatedButton(
            onPressed: _confirmWithdraw,
            child: Text(
              _amount > 0
                  ? 'Confirm Withdraw of \$${_amount.toStringAsFixed(0)}'
                  : 'Confirm Withdraw',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
