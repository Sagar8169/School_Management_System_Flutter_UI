import 'package:flutter/material.dart';
import '../../widgets/driver_widgets.dart';
import 'home_driver.dart';
import 'tickets_page.dart';
import 'trip_history_page.dart';
import 'profile_page.dart';

class DriverShell extends StatefulWidget {
  const DriverShell({super.key});
  @override
  State<DriverShell> createState() => _DriverShellState();
}

class _DriverShellState extends State<DriverShell> {
  int _currentIndex = 0;
  bool _isTelugu = true;

  final List<Widget> _pages = const [
    HomeDriver(),
    TripHistoryPage(),
    TicketsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ HEADER: Fixed on top, won't refresh on tab change
            DriverWidgets.appHeader(
              schoolName: 'Aditya International School',
              schoolInitial: 'A',
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: () => setState(() => _isTelugu = !_isTelugu),
            ),
            // ✅ BODY: Seamless content switching
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      // ✅ FOOTER: Fixed at bottom
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFE65100),
          unselectedItemColor: const Color(0xFF94A3B8),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.alt_route_rounded), label: 'Trip'),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}