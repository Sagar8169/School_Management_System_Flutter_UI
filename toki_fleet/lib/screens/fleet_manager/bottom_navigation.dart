import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:toki/screens/fleet_manager/fleet_home_page.dart';
import 'package:toki/screens/fleet_manager/fleet_more_options.dart';
import 'package:toki/screens/fleet_manager/fleet_search_routes.dart';
import 'package:toki/screens/fleet_manager/fleet_tickets.dart';

class HomeFleetManager extends ConsumerWidget {
  HomeFleetManager({super.key});
  final Color primaryTeal = const Color(0xFF009A86);
  final Color backgroundGrey = const Color(0xFFF5F5F5);
  final List<Widget> pages = [
    const FleetHomePage(),
    const FleetSearchRoutes(),
    const FleetTickets(),
    const FleetMoreOptions()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexProvider = ref.watch(bottomNaviationIndexProvider);
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: pages[indexProvider],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexProvider,
        onTap: (value) {
          ref.read(bottomNaviationIndexProvider.notifier).state = value;
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00BFA5),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
        ],
      ),
    );
  }

  final bottomNaviationIndexProvider = StateProvider((ref) {
    return 0;
  });
}
