import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/subscription/payment_options.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicehub/core/widgets/subscription/withdraw_amount_field.dart';

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

  Future<void> _confirmWithdraw() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_amount <= 0) return;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      Get.snackbar('Withdraw failed', 'Invalid user', backgroundColor: MyColors.error.withOpacity(0.1));
      return;
    }
    try {
      final fs = FirebaseFirestore.instance;
      final walletRef = fs.collection('wallets').doc(uid);
      final snap = await walletRef.get();
      final balance = (snap.data()?['balance'] as num?)?.toDouble() ?? 0.0;
      if (_amount > balance) {
        Get.snackbar('Withdraw failed', 'Insufficient balance', backgroundColor: MyColors.error.withOpacity(0.1));
        return;
      }
      await walletRef.set({
        'balance': FieldValue.increment(-_amount),
        'currency': 'USD',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      final methodLabel = _method == 'card'
          ? 'card'
          : _method == 'paypal'
              ? 'PayPal'
              : _method == 'gpay'
                  ? 'Google Pay'
                  : _method == 'bnb'
                      ? 'Binance coin'
                      : _method;
      await fs.collection('users').doc(uid).collection('transactionHistory').add({
        'datetime': FieldValue.serverTimestamp(),
        'amount': _amount,
        'type': 'withdraw',
        'title': 'Wallet withdraw',
        'description': 'Withdraw via $methodLabel',
      });
    } catch (e) {
      Get.snackbar('Withdraw failed', e.toString(), backgroundColor: MyColors.error.withOpacity(0.1));
      return;
    }
    Get.toNamed(AppRoutes.pending, arguments: {
      'title': 'Withdraw is processing',
      'subtitle': 'Please wait while we process your withdrawal',
      'redirectToWallet': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Withdraw', showBack: true, onBack: () => Get.toNamed(AppRoutes.wallet)),
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
                    child: WithdrawAmountField(
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
