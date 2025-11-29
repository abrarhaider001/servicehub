import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/view/onboarding.dart';
import 'package:servicehub/view/splash.dart';


class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const Splash()),
    GetPage(name: AppRoutes.onBoarding, page: () => const OnboardingPage()),
  ];
}
