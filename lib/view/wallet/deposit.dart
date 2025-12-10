import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/custom_app_bar.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/subscription/payment_card_preview.dart';
import 'package:servicehub/core/widgets/subscription/card_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  double _amount = 0.0;
  String _number = '';
  String _expiry = '';
  // ignore: unused_field
  String _cvv = '';

  @override
  void initState() {
    super.initState();
    final args = (Get.arguments as Map<String, dynamic>?) ?? const {};
    _amount = (args['amount'] as num?)?.toDouble() ?? 0.0;
  }

  Future<void> _handleDeposit(String number, String expiry, String cvv) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null || _amount <= 0) {
        Get.snackbar('Deposit failed', 'Invalid user or amount', backgroundColor: MyColors.error.withOpacity(0.1));
        return;
      }
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('wallets').doc(uid).set({
        'balance': FieldValue.increment(_amount),
        'currency': 'USD',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      final masked = number.replaceAll(' ', '');
      final last4 = masked.length >= 4 ? masked.substring(masked.length - 4) : '';
      await firestore.collection('users').doc(uid).collection('transactionHistory').add({
        'datetime': FieldValue.serverTimestamp(),
        'amount': _amount,
        'type': 'deposit',
        'title': 'Wallet deposit',
        'description': 'Deposited via card ****$last4',
      });
    } catch (e) {
      Get.snackbar('Deposit failed', e.toString(), backgroundColor: MyColors.error.withOpacity(0.1));
      return;
    }
    Get.toNamed(AppRoutes.pending, arguments: {
      'title': 'Deposit is processing',
      'subtitle': 'Please wait while we confirm your deposit',
      'redirectToWallet': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    final sanitized = _number.replaceAll(' ', '');
    final last4 = sanitized.length >= 4
        ? sanitized.substring(sanitized.length - 4)
        : '';
    return Scaffold(
      appBar: CustomAppBar(title: 'Deposit', showBack: true, onBack: () => Get.toNamed(AppRoutes.wallet)),
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
                    'Please enter card information.',
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
