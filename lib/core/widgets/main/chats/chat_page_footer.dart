import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Obx(() {
              final enabled = controller.canSend.value;
              return SizedBox(
                width: 44,
                height: 44,
                child: ElevatedButton(
                  onPressed: enabled ? () => controller.sendMessage(controller.inputController.text) : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ).copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.disabled) ? MyColors.grey10 : MyColors.primary,
                    ),
                  ),
                  child: Icon(Iconsax.send_2, color: enabled ? MyColors.white : MyColors.textSecondary),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
