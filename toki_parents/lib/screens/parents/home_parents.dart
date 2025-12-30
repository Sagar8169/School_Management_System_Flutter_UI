// lib/screens/parents/home_parents.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:toki/screens/parents/more_options_page.dart';
import 'package:toki/screens/parents/parents_home_page.dart';
import 'package:toki/screens/parents/reports_page.dart';

import 'bus_tracking_page.dart';

class HomeParents extends ConsumerWidget {
  HomeParents({Key? key}) : super(key: key);
  final Color _accentOrange = const Color(0xFFFF5722);
  final List<Widget> bottomNavPages = [
    const ParentsHomePage(),
    const ReportsPage(),
    const BusTrackingPage(),
    const MoreOptionsPage()
  ];

  // Navigation methods
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavIndex = ref.watch(parentBottomNavIndexProvier);
    return Scaffold(
      body: bottomNavPages[bottomNavIndex],
      bottomNavigationBar:
          _buildBottomNav(ref), // Custom bottom nav for premium feel
    );
  }

  Widget _buildBottomNav(WidgetRef ref) {
    final bottomNavIndex = ref.watch(parentBottomNavIndexProvier);
    return BottomNavigationBar(
      currentIndex: bottomNavIndex,
      onTap: (value) {
        ref.read(parentBottomNavIndexProvier.notifier).state = value;
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _accentOrange,
      backgroundColor: Colors.white,
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
      unselectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics_rounded),
            label: "Reports"),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            activeIcon: Icon(Icons.directions_bus_rounded),
            label: "Bus"),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: "More"),
      ],
    );
  }
}

final parentBottomNavIndexProvier = StateProvider((ref) {
  return 0;
});
