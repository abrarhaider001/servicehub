import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicehub/core/utils/constants/colors.dart';
import 'package:servicehub/core/utils/constants/image_strings.dart';
import 'package:servicehub/core/widgets/layout_app_bar.dart';
import 'package:servicehub/core/widgets/main/orders/detail_tile.dart';
import 'package:servicehub/core/widgets/main/orders/order_card.dart';
import 'package:iconsax/iconsax.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Map<String, dynamic>> get _ongoing => const [
        {
          'name': 'Ahmed Faruqi',
          'rating': '4.3 (878)',
          'service': 'Full house cleaning',
          'est': 'Est time: 2 h 30 min',
          'price': 80,
        },
        {
          'name': 'Fahad Ali',
          'rating': '4.3 (878)',
          'service': 'Winter cloth cleaning',
          'est': 'Est time: 2 h 30 min',
          'price': 80,
        },
        {
          'name': 'Hasan Ahmed',
          'rating': '4.3 (878)',
          'service': 'Cloth and bedsheet ironing',
          'est': 'Est time: 2 h 30 min',
          'price': 80,
        },
      ];

  List<Map<String, dynamic>> get _completed => const [
        {
          'name': 'Rashid Khan',
          'rating': '4.8 (1.2k)',
          'service': 'Kitchen deep cleaning',
          'est': 'Completed',
          'price': 65,
        },
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LayoutPagesAppBar(title: 'Orders', showBack: false, showTrailing: false),
              const SizedBox(height: 16),
              const TabBar(
                labelColor: MyColors.textPrimary,
                unselectedLabelColor: MyColors.textSecondary,
                indicatorColor: MyColors.primary,
                tabs: [
                  Tab(text: 'Ongoing order'),
                  Tab(text: 'Completed order'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.separated(
                      itemCount: _ongoing.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final it = _ongoing[i];
                        return OrderCard(
                          name: it['name'] as String,
                          rating: it['rating'] as String,
                          service: it['service'] as String,
                          est: it['est'] as String,
                          price: (it['price'] as num).toDouble(),
                          onTap: () => _showOrderSheet(it),
                        );
                      },
                    ),
                    ListView.separated(
                      itemCount: _completed.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final it = _completed[i];
                        return OrderCard(
                          name: it['name'] as String,
                          rating: it['rating'] as String,
                          service: it['service'] as String,
                          est: it['est'] as String,
                          price: (it['price'] as num).toDouble(),
                          onTap: () => _showOrderSheet(it),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderSheet(Map<String, dynamic> it) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text('Order status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
                  ),
                  IconButton(onPressed: Get.back, icon: const Icon(Icons.close, color: MyColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 8),
              Text(it['service'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: MyColors.textPrimary)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const CircleAvatar(radius: 14, backgroundColor: MyColors.grey, foregroundImage: AssetImage(MyImages.user),),
                  const SizedBox(width: 8),
                  Text(it['name'] as String, style: const TextStyle(color: MyColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Details', style: TextStyle(color: MyColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: detailTile(Iconsax.clock, it['est'] as String, 'Est time')),
                  const SizedBox(width: 10),
                  Expanded(child: detailTile(Iconsax.location, 'Sunamgonj', 'Location')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: detailTile(Iconsax.calendar, '31 Dec, 2023', 'Date')),
                  const SizedBox(width: 10),
                  Expanded(child: detailTile(Iconsax.money, '\$ ${(it['price'] as num).toString()} per hour', 'Price')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: MyColors.error, foregroundColor: MyColors.white),
                      onPressed: Get.back,
                      child: const Text('Cancel order'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: MyColors.primary, foregroundColor: MyColors.white),
                      onPressed: Get.back,
                      child: const Text('Confirm payment'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}



