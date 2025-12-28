// lib/screens/driver/trip_history_page.dart
import 'package:flutter/material.dart';
import '../../widgets/driver_widgets.dart';
import '../../routes/driver_routes.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({Key? key}) : super(key: key);

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  int _currentIndex = 1;
  bool _isTelugu = true;

  // --- 100% ORIGINAL NAVIGATION LOGIC ---
  void _navigateToPage(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0: Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (route) => false); break;
      case 2: Navigator.pushNamed(context, DriverRoutes.tickets); break;
      case 3: Navigator.pushNamed(context, DriverRoutes.profile); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double px = MediaQuery.of(context).size.width > 600 ? 40.0 : 18.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ✨ Premium Custom App Bar
            _buildCustomAppBar(px),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: px),
                children: [
                  const SizedBox(height: 20),

                  // 1. Month/Date Filter (Functional Look)
                  _buildDateFilter(),

                  const SizedBox(height: 25),

                  _buildSectionTitle("OCTOBER LOGS"),
                  const SizedBox(height: 12),

                  // 2. Trip Cards List
                  _buildModernTripCard(
                    id: 'TRIP-001',
                    date: 'October 30, 2024',
                    time: 'Morning',
                    status: 'Completed',
                    stops: '4/4',
                    dist: '25 km',
                    isCancelled: false,
                    onTap: () => Navigator.pushNamed(context, DriverRoutes.tripDetail, arguments: {'tripId': 'TRIP-001'}),
                  ),

                  _buildModernTripCard(
                    id: 'TRIP-002',
                    date: 'October 29, 2024',
                    time: 'Evening',
                    status: 'Completed',
                    stops: '4/4',
                    dist: '24 km',
                    isCancelled: false,
                    onTap: () => Navigator.pushNamed(context, DriverRoutes.tripDetail, arguments: {'tripId': 'TRIP-002'}),
                  ),

                  _buildModernTripCard(
                    id: 'TRIP-003',
                    date: 'October 28, 2024',
                    time: 'Morning',
                    status: 'Cancelled',
                    stops: '2/4',
                    dist: '12 km',
                    isCancelled: true,
                    onTap: () {}, // No detail for cancelled
                  ),

                  const SizedBox(height: 100), // ✨ Fix: Safe padding for BottomNav
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildModernNav(),
    );
  }

  // --- ✨ UI BUILDER METHODS ---

  Widget _buildCustomAppBar(double px) => Container(
    padding: EdgeInsets.symmetric(horizontal: px, vertical: 15),
    color: Colors.white,
    child: Row(children: [
      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Trip History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        Text('Records of your journeys', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ])),
      _langBadge(),
    ]),
  );

  Widget _langBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFDBEAFE))),
    child: Text(_isTelugu ? "తెలుగు" : "English", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF2563EB))),
  );

  Widget _buildDateFilter() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
    child: Row(children: [
      const Icon(Icons.calendar_month_rounded, color: Color(0xFFE65100), size: 20),
      const SizedBox(width: 12),
      const Text("October 2024", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      const Spacer(),
      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
    ]),
  );

  Widget _buildModernTripCard({required String id, required String date, required String time, required String status, required String stops, required String dist, bool isCancelled = false, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(id, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Color(0xFF94A3B8))),
                  Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B))),
                ]),
                _statusBadge(status, isCancelled),
              ]),
              const Divider(height: 30, color: Color(0xFFF1F5F9)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _statRow(Icons.wb_twilight_rounded, time),
                _statRow(Icons.pin_drop_rounded, "$stops Stops"),
                _statRow(Icons.speed_rounded, dist),
                if (!isCancelled) const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFFCBD5E1)),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String t, bool isCan) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: isCan ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(10)),
    child: Text(t, style: TextStyle(color: isCan ? Colors.red : Colors.green, fontWeight: FontWeight.w900, fontSize: 11)),
  );

  Widget _statRow(IconData i, String v) => Row(children: [Icon(i, size: 16, color: Colors.grey[400]), const SizedBox(width: 6), Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF64748B)))]);

  Widget _buildSectionTitle(String t) => Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1.2));

  Widget _buildModernNav() => Container(
    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
    child: BottomNavigationBar(
      currentIndex: _currentIndex, onTap: _navigateToPage, type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFE65100), unselectedItemColor: const Color(0xFF94A3B8), elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_max_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), activeIcon: Icon(Icons.alt_route_rounded), label: 'Trip'),
        BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), activeIcon: Icon(Icons.confirmation_number_rounded), label: 'Tickets'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    ),
  );
}