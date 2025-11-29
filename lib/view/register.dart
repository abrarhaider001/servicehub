import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/view_model/register_controller.dart';
import 'package:servicehub/core/widgets/auth/auth_top_bar.dart';
import 'package:servicehub/core/widgets/auth/auth_header.dart';
import 'package:servicehub/core/widgets/auth/register_form.dart';
import 'package:servicehub/core/widgets/auth/auth_footer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthTopBar(),
                  const AuthHeader(
                    title: 'Register',
                    subtitle: 'Please enter your credentials to proceed',
                  ),
                  const SizedBox(height: 28),
                  RegisterForm(controller: controller),
                  const SizedBox(height: 20),
                  AuthFooter(
                    text: 'Already have an account? ',
                    actionText: 'LogIn!',
                    onTap: () => Get.back(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
