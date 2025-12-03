import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:servicehub/core/utils/theme/widget_themes/text_theme.dart';
import 'package:servicehub/core/widgets/home/categories_list_view.dart';
import 'package:servicehub/core/widgets/home/home_app_bar.dart';
import 'package:servicehub/core/widgets/home/home_banner.dart';
import 'package:servicehub/core/widgets/home/popular_services.dart';
import 'package:servicehub/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final name = _user?.fullName ?? 'Guest';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeAppBar(name: name),
            const SizedBox(height: 16),
            HomeBanner(),
            const SizedBox(height: 16),
            TextField(
              decoration: MyTextFormFieldTheme.lightInputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Iconsax.search_normal, color: MyColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            Text('Categories', style: MyTextTheme.lightTextTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 18),
            CategoriesList(),
            const SizedBox(height: 18),
            Text('Popular services', style: MyTextTheme.lightTextTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            PopularServices(),
          ],
        ),
      ),
    );
  }
}






