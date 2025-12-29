// lib/screens/driver/home_driver.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:toki/screens/driver/driver_home_page.dart';
import 'package:toki/screens/driver/profile_page.dart';
import 'package:toki/screens/driver/tickets_page.dart';
import 'package:toki/screens/driver/trip_history_page.dart';
import '../../widgets/driver_widgets.dart';

class HomeDriver extends ConsumerWidget {
  HomeDriver({super.key});
  final List<Widget> pages = [
    const DriverHomePage(),
    const TripHistoryPage(),
    const TicketsPage(),
    const ProfilePage(),
  ];

  // --- ORIGINAL NAVIGATION LOGIC ---
  // void _navigateToPage(int index) {
  //   if (index == _currentIndex) return;
  //   setState(() => _currentIndex = index);

  //   switch (index) {
  //     case 0:
  //       Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (route) => false);
  //       break;
  //     case 1:
  //       Navigator.pushNamed(context, DriverRoutes.tripHistory);
  //       break;
  //     case 2:
  //       Navigator.pushNamed(context, DriverRoutes.tickets);
  //       break;
  //     case 3:
  //       Navigator.pushNamed(context, DriverRoutes.profile);
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driverIndexProvider = ref.watch(bottomNaviationIndexProviderDriver);
    // Dynamic padding for responsiveness

    return Scaffold(
      backgroundColor: DriverWidgets.scaffoldBackground,
      bottomNavigationBar: _buildBottomNav(ref),
      body: pages[driverIndexProvider],
    );
  }

  Widget _buildBottomNav(WidgetRef ref) {
    final indexProvider = ref.watch(bottomNaviationIndexProviderDriver);
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 2))),
      child: BottomNavigationBar(
        currentIndex: indexProvider,
        onTap: (value) {
          ref.read(bottomNaviationIndexProviderDriver.notifier).state = value;
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFE65100),
        unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.alt_route_rounded), label: 'Trip'),
          BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

final bottomNaviationIndexProviderDriver = StateProvider((ref) {
  return 0;
});
