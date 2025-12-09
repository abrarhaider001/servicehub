import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/view_model/chat_controller.dart';

class ChatPageChatBubbles extends StatelessWidget {
  final List<ChatMessage> messages;
  const ChatPageChatBubbles({super.key, required this.messages});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (context, index) {
        final msg = messages[index];
        final maxWidth = MediaQuery.of(context).size.width * 0.75;
        return MessageBubble(msg: msg, maxWidth: maxWidth);
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  final ChatMessage msg;
  final double maxWidth;
  const MessageBubble({super.key, required this.msg, required this.maxWidth});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _maxHeight = 200;

  double _measureTextHeight(String text, TextStyle style, double maxTextWidth) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: maxTextWidth);
    return tp.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final msg = widget.msg;
    final bubbleColor = msg.isMe ? MyColors.primary : MyColors.softGrey;
    final textColor = msg.isMe ? MyColors.white : MyColors.black;
    final align = msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final horizontalPadding = 12.0;
    final verticalPadding = 8.0;
    final contentWidth = widget.maxWidth - horizontalPadding * 2;
    final textStyle = TextStyle(color: textColor);
    final totalTextHeight = _measureTextHeight(msg.text, textStyle, contentWidth);
    final isOverflowing = totalTextHeight > _maxHeight;

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
              constraints: BoxConstraints(maxWidth: widget.maxWidth),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: _maxHeight),
                    child: Text(msg.text, style: textStyle),
                  ),
                  if (isOverflowing)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _maxHeight += 200),
                        child: Text(
                          'Read more',
                          style: TextStyle(
                            color: msg.isMe ? MyColors.white : MyColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _formatTime(msg.time),
                      style: TextStyle(
                        fontSize: 11,
                        color: msg.isMe ? MyColors.white.withOpacity(0.8) : MyColors.textSecondary,
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
  }
  
  String _formatTime(DateTime t) {
    final h12 = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final ap = t.hour >= 12 ? 'PM' : 'AM';
    return '$h12:$m $ap';
  }
}
