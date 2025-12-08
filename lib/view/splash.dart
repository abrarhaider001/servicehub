import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';
import 'package:servicehub/core/utils/device/device_utility.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';

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
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final flag = MyLocalStorage.instance().readData<dynamic>('isFirstTime') as bool?;
    final isFirstTime = flag ?? true;
    Get.offAllNamed(isFirstTime ? AppRoutes.onBoarding : AppRoutes.login);
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
              width: width * 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
