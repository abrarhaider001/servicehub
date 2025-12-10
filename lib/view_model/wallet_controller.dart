import 'package:get/get.dart';
import 'package:servicehub/core/services/wallet_service.dart';

class WalletController extends GetxController {
  final _service = WalletService();
  final balance = 0.0.obs;
  final loading = false.obs;

  @override
  void onInit() {
    _service.streamBalance().listen((b) => balance.value = b);
    super.onInit();
  }

  Future<void> refreshBalance() async {
    loading.value = true;
    try {
      balance.value = await _service.getBalance();
    } finally {
      loading.value = false;
    }
  }

  Future<void> deposit(double amount, {String method = 'card', String? cardLast4}) async {
    loading.value = true;
    try {
      await _service.deposit(amount: amount, method: method, cardLast4: cardLast4);
    } finally {
      loading.value = false;
    }
  }

  Future<void> withdraw(double amount, {String method = 'card'}) async {
    loading.value = true;
    try {
      await _service.withdraw(amount: amount, method: method);
    } finally {
      loading.value = false;
    }
  }
}

