import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyButtonTheme {
  static BoxDecoration primaryGradient({double radius = 24}) {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [MyColors.primary, MyColors.primary],
      ),
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
    this.height = 48,
    this.radius = 24,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: (gradient == null)
            ? MyButtonTheme.primaryGradient(radius: radius)
            : BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(radius),
              ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
