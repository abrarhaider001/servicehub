import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/routes/app_pages.dart';
import 'package:servicehub/core/routes/app_routes.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:servicehub/core/utils/local_storage/storage_utility.dart';

Future<void> main() async {
  // .env Loading
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    if (kDebugMode) {
      print('Warning: .env not found, using defaults');
    }
  }
  await MyLocalStorage.init('app');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ServiceHub',
      theme: MyAppTheme.lightTheme.copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.primary,
          selectionColor: Color(0x80368d9c),
          selectionHandleColor: MyColors.primary,
        ),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,

    );
  }
}
