import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/view/chat_page.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key, required List<Map<String, dynamic>> items})
    : _items = items;

  final List<Map<String, dynamic>> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: _items.length,
        separatorBuilder: (_, __) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Divider(color: MyColors.grey, height: 1, thickness: 1),
        ),
        itemBuilder: (context, i) {
          final item = _items[i];
          final name = item['name'] as String;
          final last = item['last'] as String;
          final time = item['time'] as String;
          final unread = item['unread'] as bool;
          return InkWell(
            onTap: () =>
                Get.to(() => ChatPage(conversationId: name, peerName: name, otherUserId: '',)),
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
                              time,
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
                                ),
                              ),
                            ),
                            if (unread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: MyColors.info,
                                  shape: BoxShape.circle,
                                ),
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
