import 'package:flutter/material.dart';
import 'package:servicehub/core/utils/constants/colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.textPrimary),
      ),
    );
  }
}

