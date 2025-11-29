import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/services/auth_service.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/view_model/register_controller.dart';

class RegisterForm extends StatelessWidget {
  final RegisterController controller;
  const RegisterForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Full Name', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.nameController,
            textInputAction: TextInputAction.next,
            decoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: 'John Doe',
              prefixIcon: const Icon(Icons.person_outline, color: MyColors.primary),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          Text('Address', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.addressController,
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: '123 Main St, City, Country',
              prefixIcon: const Icon(Icons.location_on_outlined, color: MyColors.primary),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          Text('Role', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.role.value,
              isDense: true,
              style: const TextStyle(fontSize: 14, color: MyColors.primary),
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: 'Choose role',
                prefixIcon: const Icon(Icons.supervisor_account_outlined, color: MyColors.primary, size: 24,),
              ).copyWith(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              ),
              items: const [
                DropdownMenuItem(value: 'user', child: Text('User')),
                DropdownMenuItem(value: 'service_provider', child: Text('Service Provider')),
              ],
              onChanged: (v) => controller.setRole(v ?? 'user'),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 20),
          Text('Email address', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: 'example123@gmail.com',
              prefixIcon: const Icon(Icons.email_outlined, color: MyColors.primary),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          Text('Password', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              obscureText: controller.obscure1.value,
              textInputAction: TextInputAction.next,
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, color: MyColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure1.value ? Icons.visibility_off : Icons.visibility,
                    color: MyColors.primary,
                  ),
                  onPressed: controller.toggleObscure1,
                ),
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 20),
          Text('Confirm Password', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Obx(
            () => TextFormField(
              controller: controller.confirmController,
              obscureText: controller.obscure2.value,
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, color: MyColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure2.value ? Icons.visibility_off : Icons.visibility,
                    color: MyColors.primary,
                  ),
                  onPressed: controller.toggleObscure2,
                ),
              ),
              validator: (v) => (v == null || v.isEmpty)
                  ? 'Required'
                  : (controller.passwordController.text != v)
                      ? 'Passwords do not match'
                      : null,
            ),
          ),
          const SizedBox(height: 16),
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
                        await AuthService.instance.signupWithEmailPassword(
                          email: controller.emailController.text.trim(),
                          password: controller.passwordController.text,
                          fullName: controller.nameController.text.trim(),
                          role: controller.role.value,
                        );
                        Get.toNamed(AppRoutes.subscription);
                      } catch (e) {
                        Get.snackbar('Signup failed', e.toString());
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
                      'Register',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

