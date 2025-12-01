import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/widgets/custom_background.dart';
import 'package:servicehub/core/widgets/onBoarding/onBoardCard.dart';
import 'package:servicehub/view_model/onboarding_controller.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: c.pageController,
                    onPageChanged: (i) => c.currentIndex.value = i,
                    itemCount: c.items.length,
                    itemBuilder: (context, index) {
                      final item = c.items[index];
                      return OnBoardCard(
                        item: item,
                        showBack: index > 0,
                        onBack: c.back,
                        onNext: () async {
                          if (c.isLast) {
                            await MyLocalStorage.instance().writeData(
                              'isFirstTime',
                              false,
                            );
                            Get.toNamed(AppRoutes.login);
                          } else {
                            c.next();
                          }
                        },
                      );
                    },
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

