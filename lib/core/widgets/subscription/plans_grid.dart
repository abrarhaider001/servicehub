import 'package:flutter/material.dart';
import 'package:servicehub/core/widgets/subscription/plan_card.dart';

class PlansGrid extends StatefulWidget {
  final void Function(String planId, String name, double price, int durationDays) onSelect;
  const PlansGrid({super.key, required this.onSelect});

  @override
  State<PlansGrid> createState() => _PlansGridState();
}

class _PlansGridState extends State<PlansGrid> {
  String? selectedId;

  void _select(String id, String name, double price, int durationDays) {
    setState(() => selectedId = id);
    widget.onSelect(id, name, price, durationDays);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlanCard(
          name: 'Starter Plan',
          subtitle: 'Seamless client experiences',
          price: 15.99,
          oldPrice: 18.99,
          durationDays: 30,
          benefits: const ['Unlimited clients and projects', 'Invoices and payment', 'Proposals and contract'],
          included: true,
          highlight: false,
          selected: selectedId == 'monthly',
          onSelect: () => _select('monthly', 'Monthly', 15.99, 30),
        ),
        const SizedBox(height: 20),
        PlanCard(
          name: 'Essentials Plan',
          subtitle: 'Productivity & automation tools',
          price: 18.99,
          oldPrice: 22.99,
          durationDays: 365,
          benefits: const ['Remove powered by Honeybook', 'Expense management', 'QuickBooks online integration'],
          included: true,
          highlight: false,
          selected: selectedId == 'yearly',
          onSelect: () => _select('yearly', 'Yearly', 18.99, 365),
        ),
      ],
    );
  }
}
