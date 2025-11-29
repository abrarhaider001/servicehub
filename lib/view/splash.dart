import 'package:flutter/material.dart';
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
