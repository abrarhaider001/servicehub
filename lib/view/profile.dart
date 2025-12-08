import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';
import 'package:servicehub/core/widgets/layout_app_bar.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/widgets/custom_dialogs/logout_confirm_dialog.dart';
import 'package:servicehub/core/widgets/profile/profile_header.dart';
import 'package:servicehub/model/user_model.dart';
import 'package:servicehub/core/widgets/profile/profile_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    final data = MyLocalStorage.instance().readData<dynamic>('user') as Map<String, dynamic>?;
    if (data != null) {
      _user = UserModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = _user?.fullName ?? 'Your Name';
    final email = _user?.email ?? 'you@example.com';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LayoutPagesAppBar(title: 'Profile', showBack: false),
            const SizedBox(height: 16),
            ProfileHeader(name: name, email: email),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: MyColors.lightGrey, borderRadius: BorderRadius.circular(16)),
              child: const Column(
                children: [
                  ProfileTile(icon: Iconsax.user, label: 'Account Settings'),
                  SizedBox(height: 10),
                  ProfileTile(icon: Iconsax.card, label: 'Payment Method'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: MyColors.lightGrey, borderRadius: BorderRadius.circular(16)),
              child: const Column(
                children: [
                  ProfileTile(icon: Iconsax.hierarchy, label: 'Care Coordination'),
                  SizedBox(height: 10),
                  ProfileTile(icon: Iconsax.heart, label: 'Favorite Doctors'),
                  SizedBox(height: 10),
                  ProfileTile(icon: Iconsax.document_text, label: 'Medical all History'),
                  SizedBox(height: 10),
                  ProfileTile(icon: Iconsax.info_circle, label: 'Helps & Supports'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _showLogoutDialog,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: const [
                    Icon(Iconsax.logout, color: MyColors.red),
                    SizedBox(width: 12),
                    Expanded(child: Text('Logout', style: TextStyle(color: MyColors.red, fontWeight: FontWeight.w600))),
                    Icon(Iconsax.arrow_right_3, color: MyColors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return LogoutConfirmDialog(
          onConfirm: () async {
            Navigator.of(context).pop();
            await MyLocalStorage.instance().removeData('isUserLoggedIn');
            await MyLocalStorage.instance().removeData('user');
            Get.offAllNamed(AppRoutes.login);
          },
        );
      },
    );
  }
}





