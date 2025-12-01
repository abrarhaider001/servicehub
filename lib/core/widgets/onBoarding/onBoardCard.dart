import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/button_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/view_model/onboarding_controller.dart';

class OnBoardCard extends StatelessWidget {
  final OnboardingItem item;
  final bool showBack;
  final VoidCallback? onBack;
  final VoidCallback onNext;
  const OnBoardCard({super.key, 
    required this.item,
    required this.onNext,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: showBack
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: onBack,
                          child: Ink(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: MyColors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(width: 40, height: 40),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(100.0),

                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          item.imageAsset,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 28.0,
                      color: MyColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.subtitle,
                    style: MyTextTheme.lightTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: GradientElevatedButton(
                      onPressed: onNext,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
