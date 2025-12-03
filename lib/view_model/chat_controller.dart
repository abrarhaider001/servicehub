import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';

class ChatMessage {
  final String text;
  final DateTime time;
  final bool isMe;
  ChatMessage({required this.text, required this.time, required this.isMe});
  Map<String, dynamic> toJson() => {
        'text': text,
        'time': time.toIso8601String(),
        'isMe': isMe,
      };
  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        text: json['text'] as String? ?? '',
        time: DateTime.tryParse(json['time'] as String? ?? '') ?? DateTime.now(),
        isMe: json['isMe'] as bool? ?? true,
      );
}

class ChatController extends GetxController {
  final String conversationId;
  final String peerName;
  ChatController({required this.conversationId, required this.peerName});

  final messages = <ChatMessage>[].obs;
  final inputController = TextEditingController();

  String get storageKey => 'chat_$conversationId';

  @override
  void onInit() {
    final data = MyLocalStorage.instance().readData<List<dynamic>>(storageKey) ?? [];
    messages.assignAll(data.map((e) => ChatMessage.fromJson(Map<String, dynamic>.from(e as Map))).toList());
    super.onInit();
  }

  Future<void> sendMessage(String text, {bool isMe = true}) async {
    if (text.trim().isEmpty) return;
    final msg = ChatMessage(text: text.trim(), time: DateTime.now(), isMe: isMe);
    messages.add(msg);
    inputController.clear();
    await MyLocalStorage.instance().writeData(storageKey, messages.map((m) => m.toJson()).toList());
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}
