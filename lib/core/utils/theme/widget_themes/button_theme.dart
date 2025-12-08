import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyButtonTheme {
  static BoxDecoration primaryGradient({double radius = 24}) {
    return BoxDecoration(
      color: MyColors.primary,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}

class GradientElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double height;
  final double radius;
  final Gradient? gradient;
  const GradientElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height = 44,
    this.radius = 12,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
