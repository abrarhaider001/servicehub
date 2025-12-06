import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProviderInfoController extends GetxController {
  final String providerId;
  ProviderInfoController({required this.providerId});

  final loading = true.obs;
  final provider = Rxn<Map<String, dynamic>>();
  final user = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    _load();
    super.onInit();
  }

  Future<void> _load() async {
    loading.value = true;
    try {
      final pSnap = await FirebaseFirestore.instance.collection('providers').doc(providerId).get();
      final pData = pSnap.data() ?? {};
      provider.value = pData;
      final ref = pData['userRef'];
      String? userId;
      if (ref is String) {
        final m = RegExp(r"/users/([^/]+)").firstMatch(ref.trim());
        userId = m?.group(1);
        if (userId == null) {
          final parts = ref.split('/').where((e) => e.isNotEmpty).toList();
          final idx = parts.indexOf('users');
          if (idx != -1 && idx + 1 < parts.length) {
            userId = parts[idx + 1];
          } else if (parts.isNotEmpty) {
            userId = parts.last;
          }
        }
        if (kDebugMode) {
          print('[ProviderInfo] userRef string="$ref" parsedUserId=$userId');
        }
      } else if (ref is DocumentReference) {
        userId = ref.id;
        if (kDebugMode) {
          print('[ProviderInfo] userRef DocumentReference id=$userId');
        }
      }
      if (userId != null) {
        try {
          final uSnap = await FirebaseFirestore.instance.collection('users').doc(userId).get();
          user.value = uSnap.data();

        } catch (e) {
          user.value = {};
        }
      } else {
        if (kDebugMode) {
          print('[ProviderInfo] userId not found from userRef=$ref');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ProviderInfo] load error: $e');
      }
    } finally {
      loading.value = false;
    }
  }
}
