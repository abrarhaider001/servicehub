import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';
import 'package:servicehub/model/user_model.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/widgets/auth/auth_header.dart';
import 'package:servicehub/core/widgets/auth/auth_top_bar.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/subscription/card_form.dart';
import 'package:servicehub/core/widgets/subscription/payment_card_preview.dart';

class CardInfoPage extends StatefulWidget {
  const CardInfoPage({super.key});

  @override
  State<CardInfoPage> createState() => _CardInfoPageState();
}

class _CardInfoPageState extends State<CardInfoPage> {
  String number = '';
  String expiry = '';
  String cvv = '';

  Future<void> _handleProceed(String number, String expiry, String cvv) async {
    await Future.delayed(const Duration(seconds: 3));
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({'isSubscriptionPaid': true});
      } catch (_) {}
    }
    try {
      final data = MyLocalStorage.instance().readData<dynamic>('user') as Map<String, dynamic>?;
      if (data != null) {
        final user = UserModel.fromJson(data).copyWith(isSubscriptionPaid: true);
        await MyLocalStorage.instance().writeData('user', user.toJson());
      }
    } catch (_) {}
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(height: 24),
                  const AuthTopBar(),
                  const AuthHeader(
                    title: 'Subscription',
                    subtitle: 'Please enter your credentials to proceed',
                  ),
                  const SizedBox(height: 36),
                  Builder(builder: (context) {
                    final args = (Get.arguments as Map<String, dynamic>?) ?? const {};
                    final price = (args['price'] as num?)?.toDouble() ?? 0.0;
                    final sanitized = number.replaceAll(' ', '');
                    final last4 = sanitized.length >= 4 ? sanitized.substring(sanitized.length - 4) : '';
                    return PaymentCardPreview(
                      amount: price,
                      last4: last4,
                      expiry: expiry.isEmpty ? 'MM/YY' : expiry,
                    );
                  }),
                  const SizedBox(height: 16),
                  CardForm(
                    onProceed: _handleProceed,
                    planPrice: ((Get.arguments as Map<String, dynamic>?)?['price'] as num?)?.toDouble(),
                    onChanged: (n, e, c) => setState(() {
                      number = n;
                      expiry = e;
                      cvv = c;
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
