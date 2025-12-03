
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/core/widgets/home/category_list.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          Category(icon: Iconsax.brush_1, label: 'Cleaning'),
          SizedBox(width: 12),
          Category(icon: Icons.wash, label: 'Washing'),
          SizedBox(width: 12),
          Category(icon: Iconsax.briefcase, label: 'Ironing'),
          SizedBox(width: 12),
          Category(icon: Iconsax.electricity, label: 'Electricity'),
          SizedBox(width: 12),
          Category(icon: Iconsax.brush_1, label: 'Cleaning'),
          SizedBox(width: 12),
          Category(icon: Icons.wash, label: 'Washing'),
          SizedBox(width: 12),
          Category(icon: Iconsax.briefcase, label: 'Ironing'),
          SizedBox(width: 12),
          Category(icon: Iconsax.electricity, label: 'Electricity'),
        ],
      ),
    );
  }
}

