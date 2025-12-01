import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';
import 'package:servicehub/core/utils/device/device_utility.dart';
import 'package:servicehub/core/widgets/custom_background.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initFlow();
  }

  Future<void> _initFlow() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Get.toNamed(AppRoutes.onBoarding);
    
  }
  @override
  Widget build(BuildContext context) {
    final width = MyDeviceUtils.getScreenWidth(context);
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          Center(
            child: Image.asset(
              MyImages.splashImage,
              width: width * 0.7,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
