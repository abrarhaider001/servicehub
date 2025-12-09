import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/view/wallet/wallet.dart';
import 'package:servicehub/view/authentication/login.dart';
import 'package:servicehub/view/onboarding.dart';
import 'package:servicehub/view/provider_info.dart';
import 'package:servicehub/view/authentication/register.dart';
import 'package:servicehub/view/splash.dart';
import 'package:servicehub/view/subscription.dart';
import 'package:servicehub/core/widgets/navbar/navbar.dart';
import 'package:servicehub/view/transaction_pending.dart';
import 'package:servicehub/view/card_info.dart';
import 'package:servicehub/view/wallet/deposit.dart';
import 'package:servicehub/view/wallet/deposit_method.dart';
import 'package:servicehub/view/wallet/withdraw.dart';
import 'package:servicehub/view/wallet/available_balance.dart';


class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const Splash()),
    GetPage(name: AppRoutes.onBoarding, page: () => const OnboardingPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage()),
    GetPage(name: AppRoutes.subscription, page: () => const SubscriptionPage()),
    GetPage(name: AppRoutes.deposit, page: () => const DepositMethodPage()),
    GetPage(name: AppRoutes.depositCard, page: () => const DepositPage()),
    GetPage(name: AppRoutes.withdraw, page: () => const WithdrawPage()),
    GetPage(name: AppRoutes.available, page: () => const AvailableBalancePage()),
    GetPage(name: AppRoutes.cardInfo, page: () => const CardInfoPage()),
    GetPage(name: AppRoutes.pending, page: () {
      final args = (Get.arguments as Map<String, dynamic>?) ?? const {};
      final t = (args['title'] as String?) ?? 'Your transaction is in progress';
      final s = (args['subtitle'] as String?) ?? 'Wait for approval, then you can login freely';
      return TransactionPendingPage(title: t, subtitle: s);
    }),
    GetPage(name: AppRoutes.wallet, page: () => const WalletPage()),
    GetPage(
      name: AppRoutes.home,
      page: () {
        final idxParam = int.tryParse(Get.parameters['index'] ?? '');
        final tabParam = Get.parameters['tab'];
        final idx = idxParam ?? (tabParam == 'chat' ? 2 : 0);
        return Navbar(initialIndex: idx);
      },
    ),
    GetPage(
      name: AppRoutes.providerInfo,
      page: () {
        final idParam = Get.parameters['id'];
        final argId = Get.arguments is String ? Get.arguments as String : null;
        final id = idParam ?? argId ?? '';
        return ProviderInfoPage(providerId: id);
      },
    ),
  ];
}
