import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/services/wallet_service.dart';

class WalletController extends GetxController {
  final _service = WalletService();
  final balance = 0.0.obs;
  final loading = false.obs;
  final history = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    _service.streamBalance().listen((b) => balance.value = b);
    _service.streamHistory().listen((items) {
      history.assignAll(items.map(_formatHistory).toList());
    });
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

  Map<String, dynamic> _formatHistory(Map<String, dynamic> it) {
    final title = (it['title'] as String?) ?? 'Transaction';
    final amount = (it['amount'] as num?)?.toDouble() ?? 0.0;
    final type = (it['type'] as String?) ?? 'order';
    final description = (it['description'] as String?) ?? '';
    final ts = it['datetime'];
    DateTime dt;
    if (ts != null && ts.runtimeType.toString() == 'Timestamp') {
      dt = ts.toDate();
    } else if (ts is DateTime) {
      dt = ts;
    } else {
      dt = DateTime.now();
    }
    final dateText = _formatDate(dt);
    final positive = type == 'deposit' || type == 'refund';
    final amountText = '${positive ? '+' : '-'}\$${amount.toStringAsFixed(2)}';
    if (kDebugMode) {
      print('$title $amountText $dateText $positive');
    }
    return {
      'title': title,
      'description': description,
      'amountText': amountText,
      'dateText': dateText,
      'positive': positive,
    };
  }

  String _formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.month)}/${two(d.day)}/${d.year}';
  }
}
