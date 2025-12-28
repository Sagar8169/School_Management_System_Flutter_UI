import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';

class HomeFleetManager extends StatefulWidget {
  const HomeFleetManager({Key? key}) : super(key: key);

  @override
  State<HomeFleetManager> createState() => _HomeFleetManagerState();
}

class _HomeFleetManagerState extends State<HomeFleetManager> {
  final Color primaryTeal = const Color(0xFF009A86);
  final Color backgroundGrey = const Color(0xFFF5F5F5);
  int _bottomIndex = 0;
  bool _showAlert = true;
  bool _isTelugu = true; // Default is Telugu, click turns to English

  void _onBottomTap(int idx) {
    if (idx == _bottomIndex) return;
    setState(() => _bottomIndex = idx);

    switch (idx) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, FleetManagerRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, FleetManagerRoutes.tickets);
        break;
      case 3:
        Navigator.pushNamed(context, FleetManagerRoutes.moreOptions);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _headerTopBar(), // Fixed Header
            Expanded(
              // Properly scrollable area
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  _profileBanner(),
                  _alertBanner(),
                  // 1. Merged Card (Schedule + Bus Overview)
                  _combinedScheduleOverviewCard(),
                  _driverManagementCard(),
                  _tripHistoryCard(),
                  _routeSummaryCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: _onBottomTap,
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

  Widget _headerTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF00C4B4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Aditya International School',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87)),
                SizedBox(height: 2),
                Text(
                  'Powered by Toki Tech',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _isTelugu = !_isTelugu; // Toggles language
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: TextStyle(color: primaryTeal, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileBanner() {
    return Container(
      width: double.infinity,
      color: primaryTeal,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 4),
          Opacity(
            opacity: 0.9,
            child: const Text(
              'Mr. Suresh Kumar • Fleet Manager',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _miniStatCard('12', 'Total Buses'),
              const SizedBox(width: 12),
              _miniStatCard('8', 'On Route'),
              const SizedBox(width: 12),
              _miniStatCard('18', 'Drivers'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.calendar_today_outlined, color: Colors.white, size: 14),
              SizedBox(width: 6),
              Text(
                'Saturday, November 9, 2025',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStatCard(String big, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              big,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertBanner() {
    if (!_showAlert) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        border: Border.all(color: const Color(0xFFFFCDD2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: Colors.red, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cyclone Alert - School Closed',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Due to severe cyclone warning, school will remain closed on October 21-22, 2025. Stay safe!',
                      style: TextStyle(
                          color: Color(0xFF555555), fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => setState(() => _showAlert = false),
                child: const Icon(Icons.close, color: Colors.grey, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardWrapper({
    required Widget leading,
    required String title,
    String? subtitle,
    required Widget child,
    VoidCallback? onTap,
  }) {
    final content = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              leading,
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (subtitle != null) const SizedBox(height: 2),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );

    if (onTap == null) return content;

    return GestureDetector(
      onTap: onTap,
      child: content,
    );
  }

  Widget _circleIcon(IconData icon, Color bg) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.black87.withOpacity(0.7), size: 22),
    );
  }

  // --- MERGED CARD LOGIC HERE ---
  Widget _combinedScheduleOverviewCard() {
    return _cardWrapper(
      leading: _circleIcon(Icons.dashboard_customize, const Color(0xFFE0F2F1)),
      title: "Schedule & Overview",
      subtitle: 'Today\'s operations & Fleet Status',
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Schedule Section ---
          GestureDetector(
            onTap: () {
              final route =
                  '${FleetManagerRoutes.trips}?shift=morning&date=2025-11-09';
              Navigator.pushNamed(context, route);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF26A69A)),
                color: const Color(0xFFE0F2F1).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF26A69A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F2F1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'In Progress',
                                style: TextStyle(
                                    color: Color(0xFF00897B),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Morning Pickup',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '7:00 AM - 8:30 AM • 8 buses active',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Evening Drop',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '3:00 PM - 4:30 PM • 8 buses scheduled',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // --- Bus Overview Section (Merged) ---
          const Text(
            "Fleet Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _overviewStat('8', 'On Route', const Color(0xFF00C853)),
              const SizedBox(width: 12),
              _overviewStat('2', 'In Garage', const Color(0xFFFFAB00)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _overviewStat('1', 'Maintenance', const Color(0xFFFF5252)),
              const SizedBox(width: 12),
              _overviewStat('1', 'Reserved', const Color(0xFF7C4DFF)),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _listRow('Route 5 - KA-01-AB-1234', 'On Route',
                  const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
              const SizedBox(height: 12),
              _listRow('Route 3 - KA-01-CD-5678', 'On Route',
                  const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, FleetManagerRoutes.busOverview);
            },
            child: Row(
              children: const [
                Text(
                  "View full fleet details",
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewStat(String big, String label, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            big,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _listRow(
      String title, String badge, Color badgeBg, Color badgeText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black87),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            badge,
            style: TextStyle(color: badgeText, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _driverManagementCard() {
    return _cardWrapper(
      leading: _circleIcon(Icons.people_outline, const Color(0xFFF3E5F5)),
      title: 'Driver Management',
      subtitle: '18 active drivers',
      onTap: () {
        Navigator.pushNamed(context, FleetManagerRoutes.drivers);
      },
      child: Column(
        children: [
          Row(
            children: [
              _smallDriverStat('15', 'On Duty', const Color(0xFF00C853)),
              Container(width: 1, height: 40, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(horizontal: 16)),
              _smallDriverStat('2', 'On Leave', const Color(0xFFFFAB00)),
              Container(width: 1, height: 40, color: Colors.grey.shade200, margin: const EdgeInsets.symmetric(horizontal: 16)),
              _smallDriverStat('1', 'Standby', const Color(0xFF448AFF)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, FleetManagerRoutes.search);
            },
            child: Row(
              children: const [
                Text(
                  "Tap 'Search' tab to view drivers by route",
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallDriverStat(String big, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          big,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }

  Widget _tripHistoryCard() {
    return _cardWrapper(
      leading: _circleIcon(Icons.access_time, const Color(0xFFFFF3E0)),
      title: 'Trip History',
      subtitle: 'View all completed trips',
      onTap: () {
        Navigator.pushNamed(context, FleetManagerRoutes.tripHistory);
      },
      child: Column(
        children: [
          // 2. Added Distance in KM
          _historyRow("Today's Trips", '24', '140 km', const Color(0xFF009688)),
          const SizedBox(height: 12),
          _historyRow('This Week', '168', '1,250 km', Colors.grey.shade700),
          const SizedBox(height: 12),
          _historyRow('This Month', '672', '5,800 km', Colors.grey.shade700),
        ],
      ),
    );
  }

  // Updated to include distance
  Widget _historyRow(String title, String count, String distance, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14)),
        Row(
          children: [
            Text(
              distance,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _routeSummaryCard() {
    return _cardWrapper(
      leading: _circleIcon(Icons.map_outlined, const Color(0xFFE8F5E9)),
      title: 'Route Summary',
      subtitle: '8 active routes',
      onTap: () {
        Navigator.pushNamed(context, FleetManagerRoutes.routes);
      },
      child: Column(
        children: [
          _routeRow('Route 1 - North Zone', '45 students • 2 buses'),
          const SizedBox(height: 16),
          _routeRow('Route 2 - South Zone', '52 students • 2 buses'),
          const SizedBox(height: 16),
          _routeRow('Route 3 - East Zone', '38 students • 1 bus'),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, FleetManagerRoutes.search);
            },
            child: Row(
              children: const [
                Text(
                  "Tap 'Search' tab to view students by route",
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeRow(String title, String subtitle) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}