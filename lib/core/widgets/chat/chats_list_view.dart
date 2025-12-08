import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/view/chat_page.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({
    super.key,
    required this.items,
  });

  final List<Map<String, Object>> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Divider(color: MyColors.grey, height: 1, thickness: 1),
        ),
        itemBuilder: (context, i) {
          final item = items[i];
          final name = item['name'] as String;
          final last = item['last'] as String;
          final time = item['time'] as DateTime;
          final timeText = _formatListTime(time);
          final unread = item['unread'] as bool;
          final chatID = item['chatID'] as String;
          final otherUserID = item['otherUserID'] as String;
          return InkWell(
            onTap: () => Get.to(() => ChatPage(conversationId: chatID, peerName: name, otherUserId: otherUserID)),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: MyColors.grey,
                    child: Text(
                      name.isNotEmpty ? name[0] : '?',
                      style: const TextStyle(color: MyColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              timeText,
                              style: const TextStyle(
                                color: MyColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                last,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: MyColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            if (unread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(color: MyColors.info, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String _formatListTime(DateTime t) {
  final now = DateTime.now();
  final isSameDay = t.year == now.year && t.month == now.month && t.day == now.day;
  if (isSameDay) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final ap = t.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ap';
  }
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  final m = months[t.month - 1];
  if (t.year == now.year) {
    return '$m ${t.day}';
  }
  return '$m ${t.day}, ${t.year}';
}