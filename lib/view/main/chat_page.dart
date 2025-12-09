import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/widgets/main/chats/chat_page_app_bar.dart';
import 'package:servicehub/core/widgets/main/chats/chat_page_chat_bubbles.dart';
import 'package:servicehub/core/widgets/main/chats/chat_page_footer.dart';
import 'package:servicehub/view_model/chat_controller.dart';

class ChatPage extends StatelessWidget {
  final String conversationId;
  final String peerName;
  final String otherUserId;
  const ChatPage({super.key, required this.conversationId, required this.peerName, required this.otherUserId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController(conversationId: conversationId, peerName: peerName, otherUserId: otherUserId));
    return Scaffold(
      appBar: ChatPageAppBar(title: peerName),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final msgs = controller.messages;
              final _ = msgs.length;
              return ChatPageChatBubbles(messages: msgs.toList());
            }),
          ),
          ChatPageFooter(controller: controller),
        ],
      ),
    );
  }
}
