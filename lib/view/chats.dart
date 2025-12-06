import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/view_model/chats_controller.dart';
import 'package:servicehub/view/chat_page.dart';
import 'package:servicehub/core/widgets/layout_app_bar.dart';
import 'package:servicehub/core/widgets/chat/empty_chats.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});


  @override
  Widget build(BuildContext context) {
    final c = Get.put(ChatsController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LayoutPagesAppBar(title: 'Chats', showBack: false, showTrailing: false),
            const SizedBox(height: 12),
            TextField(
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: 'Search message',
                prefixIcon: const Icon(Iconsax.search_normal, color: MyColors.primary),
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final meta = c.items;
              // Empty chats
              if (meta.isEmpty) {
                return const Expanded(child: Center(child: EmptyChats()));
              }
              final items = meta
                  .map((m) => {
                        'name': c.names[m.otherUserID] ?? m.otherUserID,
                        'last': m.lastMessage,
                        'time': (m.lastMessageTime ?? DateTime.now()).toLocal().toIso8601String(),
                        'unread': !m.isLastMessageRead,
                        'chatID': m.chatID,
                        'otherUserID': m.otherUserID,
                      })
                  .toList();
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
                    final timeIso = item['time'] as String;
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
                                        timeIso,
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
                                          decoration: const BoxDecoration(color: MyColors.primary, shape: BoxShape.circle),
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
            }),
          ],
        ),
      ),
    );
  }
}


