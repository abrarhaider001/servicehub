
import 'package:flutter/material.dart';
import 'package:servicehub/core/widgets/main/home/category_list.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/view_model/categories_controller.dart';
import 'package:servicehub/view_model/providers_controller.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  IconData _iconFor(String name) {
    switch (name.toLowerCase().trim()) {
      case 'painting':
        return Icons.brush;
      case 'cleaning':
        return Icons.bubble_chart_sharp;
      case 'electrical':
        return Icons.electric_bolt_rounded;
      case 'plumbing':
        return Icons.plumbing;
      case 'carpentry':
        return Icons.carpenter;
      case 'gardening':
        return Icons.grade_rounded;
      default:
        return Icons.ac_unit_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
    final providersController = Get.put(ProvidersController());
    return Obx(() {
      if (controller.loading.value) {
        return _CategoriesShimmer();
      }
      final items = controller.names.isEmpty
          ? const ['painting', 'plumbing', 'carpentry', 'cleaning', 'gardening', 'electrical']
          : controller.names.toList();
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final name in items) ...[
              Category(
                icon: _iconFor(name),
                label: _label(name),
                onTap: () => providersController.setCategory(name),
              ),
              const SizedBox(width: 12),
            ],
          ],
        ),
      );
    });
  }

  String _label(String name) {
    final s = name.trim();
    if (s.isEmpty) return '';
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  Widget _CategoriesShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(6, (i) => const _CategorySkeleton()),
      ),
    );
  }
}

class _CategorySkeleton extends StatefulWidget {
  const _CategorySkeleton();
  @override
  State<_CategorySkeleton> createState() => _CategorySkeletonState();
}

class _CategorySkeletonState extends State<_CategorySkeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final gradient = LinearGradient(
          colors: [MyColors.grey10, MyColors.lightGrey, MyColors.grey10],
          stops: const [0.1, 0.5, 0.9],
          begin: Alignment(-1 + _controller.value * 2, 0),
          end: Alignment(1 + _controller.value * 2, 0),
        );
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), gradient: gradient),
              ),
              const SizedBox(height: 6),
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), gradient: gradient),
              ),
            ],
          ),
        );
      },
    );
  }
}

