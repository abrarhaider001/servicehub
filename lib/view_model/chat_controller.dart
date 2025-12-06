import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicehub/repository/chat_repository.dart';

class ChatMessage {
  final String text;
  final DateTime time;
  final bool isMe;
  ChatMessage({required this.text, required this.time, required this.isMe});
}

class ChatController extends GetxController {
  final String conversationId;
  final String peerName;
  final String otherUserId;
  ChatController({required this.conversationId, required this.peerName, required this.otherUserId});

  final messages = <ChatMessage>[] .obs;
  final inputController = TextEditingController();
  final _repo = ChatRepository();
  final canSend = false.obs;

  String get myId => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void onInit() {
    messages.clear();
    _repo.streamMessages(conversationId).listen((ms) {
      final mapped = ms
          .map((m) => ChatMessage(text: m.message, time: m.createdAt, isMe: m.senderID == myId))
          .toList();
      messages.assignAll(mapped);
    });
    _repo.markChatOpen(chatID: conversationId, userID: myId);
    inputController.addListener(() {
      canSend.value = inputController.text.trim().isNotEmpty;
    });
    super.onInit();
  }

  Future<void> sendMessage(String text) async {
    final t = text.trim();
    if (t.isEmpty) return;
    inputController.clear();
    await _repo.sendMessage(chatID: conversationId, senderID: myId, receiverID: otherUserId, text: t);
    inputController.clear();
    canSend.value = false;
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}
