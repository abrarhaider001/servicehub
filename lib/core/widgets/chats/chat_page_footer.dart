import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/view_model/chat_controller.dart';

class ChatPageFooter extends StatelessWidget {
  final ChatController controller;
  const ChatPageFooter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: const BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.inputController,
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: const TextStyle(color: MyColors.darkerGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 1, color: MyColors.darkerGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 1, color: MyColors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 2, color: MyColors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 44,
              height: 44,
              child: ElevatedButton(
                onPressed: () => controller.sendMessage(
                  controller.inputController.text,
                  isMe: true,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  backgroundColor: MyColors.primary,
                ),
                child: const Icon(Iconsax.send_2, color: MyColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
