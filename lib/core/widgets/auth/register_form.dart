import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';
import 'package:servicehub/core/services/auth_service.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/view_model/register_controller.dart';
import 'package:servicehub/core/utils/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicehub/core/utils/exceptions/firebase_auth_exceptions.dart';

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
              prefixIcon: const Icon(
                Icons.person_outline,
                color: MyColors.primary,
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (v.length > 15) return 'Maximum 15 characters';
              return null;
            },
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
              prefixIcon: const Icon(
                Icons.location_on_outlined,
                color: MyColors.primary,
              ),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          Text('Role', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          DropDownTextField(
            clearOption: false,
            dropDownItemCount: 2,
            enableSearch: false,
            controller: controller.roleDropController,
            textFieldDecoration: MyTextFormFieldTheme.lightInputDecoration(
              hintText: 'Choose role',
              prefixIcon: const Icon(
                Icons.supervisor_account_outlined,
                color: MyColors.primary,
                size: 24,
              ),
            ).copyWith(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 18,
              ),
            ),
            dropDownList: const [
              DropDownValueModel(name: 'User', value: 'user'),
              DropDownValueModel(name: 'Service Provider', value: 'service_provider'),
            ],
            validator: (String? value) => (value == null || value.isEmpty) ? 'Required' : null,
            onChanged: (val) {
              final model = val as DropDownValueModel;
              final v = model.value?.toString() ?? 'user';
              controller.setRole(v);
            },
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
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: MyColors.primary,
              ),
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
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: MyColors.primary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure1.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: MyColors.primary,
                  ),
                  onPressed: controller.toggleObscure1,
                ),
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Confirm Password',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Obx(
            () => TextFormField(
              controller: controller.confirmController,
              obscureText: controller.obscure2.value,
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: MyColors.primary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscure2.value
                        ? Icons.visibility_off
                        : Icons.visibility,
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
                      if (!(controller.formKey.currentState?.validate() ??
                          false)) {
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
                        await MyLocalStorage.instance().writeData(
                          'isUserLoggedIn',
                          true,
                        );
                        Get.toNamed(AppRoutes.subscription);
                      } on MyFirebaseAuthException catch (e) {
                        final msg = e.message;
                        Get.snackbar('Signup failed', msg, backgroundColor: MyColors.error.withOpacity(0.1));
                      } on FirebaseAuthException catch (e) {
                        final msg = MyExceptions.fromCode(e.code).message;
                        Get.snackbar('Signup failed', msg, backgroundColor: MyColors.error.withOpacity(0.1));
                      } catch (e) {
                        final msg = e is MyExceptions ? e.message : const MyExceptions().message;
                        Get.snackbar('Signup failed', msg, backgroundColor: MyColors.error.withOpacity(0.1));
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
