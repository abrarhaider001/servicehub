import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProvidersController extends GetxController {
  final loading = true.obs;
  final selectedCategory = RxnString();
  final providers = <Map<String, dynamic>>[].obs;
  StreamSubscription<QuerySnapshot>? _sub;

  @override
  void onInit() {
    _subscribe();
    super.onInit();
  }

  void setCategory(String? name) {
    selectedCategory.value = name?.toLowerCase();
    _subscribe();
  }

  void _subscribe() {
    _sub?.cancel();
    loading.value = true;
    Query q = FirebaseFirestore.instance.collection('providers');
    final cat = selectedCategory.value;
    if (cat != null && cat.isNotEmpty) {
      q = q.where('skills', arrayContains: cat);
    }
    _sub = q.snapshots().listen((snap) {
      final list = snap.docs.map((d) {
        final data = d.data() as Map<String, dynamic>;
        return {'id': d.id, ...data};
      }).toList();
      providers.assignAll(list);
      loading.value = false;
    }, onError: (_) {
      providers.clear();
      loading.value = false;
    });
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
