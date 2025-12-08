import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/view_model/chat_controller.dart';

class ChatPageChatBubbles extends StatelessWidget {
  final List<ChatMessage> messages;
  const ChatPageChatBubbles({super.key, required this.messages});
  String _formatTime(DateTime t) {
    final h12 = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final ap = t.hour >= 12 ? 'PM' : 'AM';
    return '$h12:$m $ap';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (context, index) {
        final msg = messages[index];
        final align = msg.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start;
        final bubbleColor = msg.isMe ? MyColors.primary : MyColors.softGrey;
        final textColor = msg.isMe ? MyColors.white : MyColors.black;
        return Column(
          crossAxisAlignment: align,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: msg.isMe ? 0 : 30,
                left: msg.isMe ? 30 : 0,
              ),
              child: IntrinsicWidth(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg.text, style: TextStyle(color: textColor)),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _formatTime(msg.time),
                          style: TextStyle(
                            fontSize: 11,
                            color: msg.isMe
                                ? MyColors.white.withOpacity(0.8)
                                : MyColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        );
      },
    );
  }
}
