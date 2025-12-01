import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/model/user_model.dart';
import 'package:servicehub/view_model/login_controller.dart';
import 'package:servicehub/core/services/auth_service.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';

class LoginForm extends StatelessWidget {
  final LoginController controller;
  const LoginForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Email address', style: MyTextTheme.lightTextTheme.titleLarge),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: 'example123@gmail.com',
              prefixIcon: const Icon(Icons.email_outlined, color: MyColors.primary),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          Text('Password', style: MyTextTheme.lightTextTheme.titleLarge),
          const SizedBox(height: 8),
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              obscureText: controller.obscure.value,
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, color: MyColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure.value ? Icons.visibility_off : Icons.visibility,
                    color: MyColors.primary,
                  ),
                  onPressed: controller.toggleObscure,
                ),
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?', style: TextStyle(color: MyColors.primary)),
            ),
          ),
          const SizedBox(height: 18),
          Obx(
            () => GradientElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                      if (!(controller.formKey.currentState?.validate() ?? false)) {
                        return;
                      }
                      controller.isLoading.value = true;
                      try {
                        await AuthService.instance.loginWithEmailPassword(
                          email: controller.emailController.text.trim(),
                          password: controller.passwordController.text,
                        );
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        final snap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
                        final data = snap.data() ?? {};
                        final isPaid = (data['isSubscriptionPaid'] as bool?) ?? false;
                        final createdAtTs = data['createdAt'];
                        final createdAt = createdAtTs is Timestamp ? createdAtTs.toDate() : DateTime.now();
                        final addresses = (data['address'] as List<dynamic>? ?? const [])
                            .map((e) => AddressModel.fromJson((e as Map).cast<String, dynamic>()))
                            .toList();
                        final deviceTokens = ((data['metadata'] as Map<String, dynamic>? ?? const {})['deviceTokens'] as List<dynamic>? ?? const [])
                            .map((e) => e.toString())
                            .toList();
                        final userModel = UserModel(
                          id: uid,
                          fullName: (data['fullName'] as String?) ?? '',
                          email: (data['email'] as String?) ?? controller.emailController.text.trim(),
                          role: (data['role'] as String?) ?? 'user',
                          profileImageUrl: (data['profileImageUrl'] as String?) ?? '',
                          createdAt: createdAt,
                          favorites: (data['favorites'] as List<dynamic>? ?? const []).map((e) => e.toString()).toList(),
                          city: (data['city'] as String?) ?? '',
                          address: addresses,
                          deviceTokens: deviceTokens,
                          walletId: (data['walletId'] as String?) ?? 'wallet_$uid',
                          isSubscriptionPaid: isPaid,
                        );
                        await MyLocalStorage.instance().writeData('user', userModel.toJson());
                        Get.offAllNamed(isPaid ? AppRoutes.home : AppRoutes.subscription);
                      } catch (e) {
                        Get.snackbar('Login failed', e.toString());
                      } finally {
                        controller.isLoading.value = false;
                      }
                    },
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

