import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/core/widgets/chat/chats_list_view.dart';
import 'package:servicehub/core/widgets/layout_app_bar.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  List<Map<String, dynamic>> get _items => const [
        {
          'name': 'My Honey',
          'last': 'Beso beli es coklat yuu',
          'time': '15:23',
          'unread': true,
        },
        {
          'name': 'Si Botak',
          'last': 'San, aku udah di lokasi nih',
          'time': '17:12',
          'unread': false,
        },
        {
          'name': 'James Kribo',
          'last': 'Halo broo, weekend maen',
          'time': '17:00',
          'unread': true,
        },
        {
          'name': 'Dribbble & Behance',
          'last': 'Pagi guys, izin share shot terbaru',
          'time': '13:05',
          'unread': false,
        },
        {
          'name': 'Mike Michiel',
          'last': 'Hi, can you give me extra...',
          'time': '12:33',
          'unread': true,
        },
        {
          'name': 'Microstock Contributor',
          'last': "I've upload my new design on...",
          'time': '12:23',
          'unread': false,
        },
        {
          'name': 'Upwork Freelance',
          'last': 'No, i think machine learning...',
          'time': '10:32',
          'unread': false,
        },
        {
          'name': 'Rafiee Rohmat',
          'last': 'San, titip ayam geprek dong',
          'time': '08:23',
          'unread': false,
        },
        {
          'name': 'Ahmad Arianto',
          'last': 'Hahaha, kaya nya oke sih',
          'time': '08:00',
          'unread': false,
        },
      ];

  @override
  Widget build(BuildContext context) {
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
            ChatsListView(items: _items),
          ],
        ),
      ),
    );
  }
}


