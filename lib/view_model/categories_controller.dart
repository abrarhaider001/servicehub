import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final names = <String>[].obs;
  final loading = true.obs;
  StreamSubscription<QuerySnapshot>? _sub;

  @override
  void onInit() {
    _sub = FirebaseFirestore.instance.collection('categories').snapshots().listen((snap) {
      final docs = snap.docs;
      final items = docs
          .map((d) => d.data())
          .map((data) => (data as Map<String, dynamic>?)?['name'] as String?)
          .where((name) => name != null && name.isNotEmpty)
          .map((name) => name!)
          .toList();
      names.assignAll(items);
      loading.value = false;
    }, onError: (_) {
      names.assignAll(const ['painting', 'plumbing', 'carpentry', 'cleaning', 'gardening', 'electrical']);
      loading.value = false;
    });
    super.onInit();
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
