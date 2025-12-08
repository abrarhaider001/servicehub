import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/view_model/chats_controller.dart';
import 'package:servicehub/core/widgets/layout_app_bar.dart';
import 'package:servicehub/core/widgets/chat/empty_chats.dart';
import 'package:servicehub/core/widgets/chat/chats_list_view.dart';

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
              if (meta.isEmpty) {
                return const Expanded(child: Center(child: EmptyChats()));
              }
              final items = meta
                  .map((m) => {
                        'name': c.names[m.otherUserID] ?? m.otherUserID,
                        'last': m.lastMessage,
                        'time': (m.lastMessageTime ?? DateTime.now()).toLocal(),
                        'unread': (!m.isLastMessageRead) && (m.senderID != c.myId),
                        'chatID': m.chatID,
                        'otherUserID': m.otherUserID,
                      })
                  .toList();
              return ChatListView(items: items);
            }),
          ],
        ),
      ),
    );
  }
}





