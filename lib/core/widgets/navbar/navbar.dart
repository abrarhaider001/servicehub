import 'package:flutter/material.dart';
import 'package:servicehub/core/widgets/navbar/custom_bottom_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:servicehub/view/home.dart';
import 'package:servicehub/view/orders.dart';
import 'package:servicehub/view/chats.dart';
import 'package:servicehub/view/profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  List<Widget> get _pages => const [
        HomePage(),
        OrdersPage(),
        ChatsPage(),
        ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // const CustomBackground(),
          IndexedStack(index: _index, children: _pages),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home_1), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.task), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Iconsax.message), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}

