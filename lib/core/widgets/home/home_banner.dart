import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(MyImages.homeBannerBackgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('One App. Every Service.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
          SizedBox(height: 8),
          Text('Body From cleaning to repairs — book trusted professionals in minutes.', style: TextStyle(color: MyColors.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
