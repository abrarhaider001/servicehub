import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/animations_strings.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:lottie/lottie.dart';

class TransactionPendingPage extends StatefulWidget {
  final String title;
  final String subtitle;
  const TransactionPendingPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<TransactionPendingPage> createState() => _TransactionPendingPageState();
}

class _TransactionPendingPageState extends State<TransactionPendingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).maybePop();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset(
                    frameRate: FrameRate.max,
                    MyAnimations.successAnimation,
                    repeat: false,
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.title, style: MyTextTheme.lightTextTheme.displayMedium),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Center(
                    child: Text(
                      widget.subtitle,
                      style: MyTextTheme.lightTextTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
