import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_trips_page.dart';
import 'notification_page.dart';


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
            _buildWhiteTopBar(),
            Expanded(
              // Properly scrollable area
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  _profileBanner(context),
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

  // (Headers, Buttons, etc. same as your snippet with small fixes)
  Widget _buildWhiteTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: primaryTeal.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.school_rounded, color: primaryTeal, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aditya International', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                Text('Fleet Management System', style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          Text("తెలుగు", style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _profileBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryTeal, primaryTeal.withBlue(150)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryTeal.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      // Height kam karne ke liye padding adjust ki hai
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP ROW: NAME & NOTIFICATION ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mr. Suresh Kumar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Slightly smaller
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fleet Manager • AIS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              // Notification Button with Navigation
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                ),
                child: _topIconButton(Icons.notifications_active_outlined),
              ),
            ],
          ),

          const SizedBox(height: 20), // Spacing kam ki hai

          // --- STATS (COMPACT GLASS STYLE) ---
          Row(
            children: [
              Expanded(child: _miniStatGlass('12', 'Buses', Icons.directions_bus_filled_rounded)),
              const SizedBox(width: 10),
              Expanded(child: _miniStatGlass('08', 'Live', Icons.sensors_rounded)),
              const SizedBox(width: 10),
              Expanded(child: _miniStatGlass('18', 'Staff', Icons.people_alt_rounded)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStatGlass(String val, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12), // Compact padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white60, size: 16),
          const SizedBox(height: 4),
          Text(
            val,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _topIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.25),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🚨 Icon Bubble
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              /// 📄 Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cyclone Alert - School Closed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Due to severe cyclone warning, school will remain closed on October 21–22, 2025. Stay safe!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              /// ❌ Close Button
              Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => setState(() => _showAlert = false),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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

  Widget _combinedScheduleOverviewCard() {
    return _cardWrapper(
      title: "Schedule & Overview",
      leading: Icon(Icons.analytics_rounded, color: primaryTeal, size: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. Operations Timeline ---
          const Text(
            "OPERATIONS TIMELINE",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1.2),
          ),
          const SizedBox(height: 16),
          _buildTimelineItem(
            "Morning Pickup",
            "07:00 AM - 08:30 AM",
            "8 Buses Active",
            true,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => FleetTripsPage(shift: 'Morning Pickup'))),
          ),
          const SizedBox(height: 12),
          _buildTimelineItem(
            "Evening Drop",
            "03:00 PM - 04:30 PM",
            "8 Buses Scheduled",
            true,
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => FleetTripsPage(shift: 'Evening Drop'))),
          ),

          const SizedBox(height: 24),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 24),

          // --- 2. Fleet Status Grid ---
          const Text(
            "FLEET ANALYTICS",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1.2),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFleetGridStat("08", "ON ROUTE", Colors.green),
              const SizedBox(width: 12),
              _buildFleetGridStat("02", "IN GARAGE", Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFleetGridStat("01", "SERVICE", Colors.redAccent),
              const SizedBox(width: 12),
              _buildFleetGridStat("01", "RESERVED", Colors.indigoAccent),
            ],
          ),

          const SizedBox(height: 25),

          // --- 3. PREMIUM VIEW FULL FLEET BUTTON ---
          InkWell(
            onTap: () => Navigator.pushNamed(context, FleetManagerRoutes.busOverview),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryTeal.withOpacity(0.06), // Very light teal theme
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryTeal.withOpacity(0.12)),
              ),
              child: Row(
                children: [
                  // Icon Background
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: primaryTeal.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2))
                      ],
                    ),
                    child: Icon(Icons.directions_bus_filled_rounded, size: 18, color: primaryTeal),
                  ),
                  const SizedBox(width: 16),
                  // Text Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "View Full Fleet Details",
                          style: TextStyle(
                              color: primaryTeal,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Track maintenance, documents & logs",
                          style: TextStyle(color: primaryTeal.withOpacity(0.6), fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // Trailing Arrow
                  Icon(Icons.arrow_forward_ios_rounded, size: 14, color: primaryTeal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, String status, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? primaryTeal.withOpacity(0.05) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isActive ? primaryTeal.withOpacity(0.1) : Colors.black.withOpacity(0.03)),
        ),
        child: Row(
          children: [
            // Moving Pulse for active trip
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isActive ? primaryTeal : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    boxShadow: isActive ? [BoxShadow(color: primaryTeal.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)] : [],
                  ),
                ),
                Container(width: 2, height: 20, color: Colors.black.withOpacity(0.05)),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text("$time  •  $status", style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: primaryTeal, borderRadius: BorderRadius.circular(6)),
                child: const Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFleetGridStat(String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
                height: 35, width: 4,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10))
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(val, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 20)),
                Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
              ],
            ),
          ],
        ),
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

  void _showLeaveRequestDialog(String driverName, String reason) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Icon
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange.withOpacity(0.1),
              child: const Icon(Icons.time_to_leave_rounded, color: Colors.orange, size: 30),
            ),
            const SizedBox(height: 16),
            const Text("Leave Request", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(
              "Request from $driverName",
              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            // Reason Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.blueGrey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Reason: $reason",
                      style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Rejected"), backgroundColor: Colors.redAccent));
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("REJECT", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Approved"), backgroundColor: Colors.green));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("APPROVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _driverManagementCard() {
    return _cardWrapper(
      title: 'Driver Management',
      leading: Icon(Icons.badge_rounded, color: primaryTeal, size: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. Modern Stat Grid ---
          Row(
            children: [
              _driverStatBox("15", "ON DUTY", Colors.green),
              const SizedBox(width: 10),
              _driverStatBox("02", "ON LEAVE", Colors.orange),
              const SizedBox(width: 10),
              _driverStatBox("01", "STANDBY", Colors.blue),
            ],
          ),

          const SizedBox(height: 20),

          // --- 2. Interactive Leave Request Section ---
          InkWell(
            onTap: () => _showLeaveApprovalSheet("Vikram Singh", "Family Emergency"),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.orange.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  // Pulse Effect Icon
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 36, width: 36,
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.15), shape: BoxShape.circle),
                      ),
                      const Icon(Icons.notification_important_rounded, size: 20, color: Colors.orange),
                    ],
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Leave Requests",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF7C2D12)),
                        ),
                        Text(
                          "1 Driver is waiting for approval",
                          style: TextStyle(fontSize: 11, color: Color(0xFF9A3412), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.orange),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- 3. Manage Directory Button ---
          InkWell(
            onTap: () => Navigator.pushNamed(context, FleetManagerRoutes.drivers),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryTeal, primaryTeal.withOpacity(0.85)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: primaryTeal.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.manage_accounts_rounded, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text(
                    "MANAGE DIRECTORY",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// --- 4. THE POPUP LOGIC (Approval Popup) ---
  void _showLeaveApprovalSheet(String driverName, String reason) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔶 ICON HEADER
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade400,
                        Colors.deepOrange.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.event_busy_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 18),

                /// TITLE
                const Text(
                  "Leave Approval",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),

                const SizedBox(height: 8),

                /// SUBTEXT
                Text(
                  "$driverName has requested leave.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 22),

                /// REASON CARD
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          reason,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                /// ACTION BUTTONS
                Row(
                  children: [
                    /// REJECT
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.red.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "REJECT",
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// APPROVE
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "APPROVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


// --- 5. Supporting Stat Box Widget ---
  Widget _driverStatBox(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: color)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

// --- Supporting Stat Box Widget ---
  Widget _buildDriverStatusItem(String count, String label, Color color) {
    return Column(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.15), width: 1.5),
          ),
          child: Center(
            child: Text(
              count,
              style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 19),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.blueGrey.shade400,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
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
      title: 'Trip Analytics',
      leading: Icon(Icons.auto_graph_rounded, color: primaryTeal, size: 20),
      child: Column(
        children: [
          // --- 1. Today's Highlight Card ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryTeal.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryTeal.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                _buildCircularIndicator('24', 0.8, Colors.orange),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("TODAY'S OPERATIONS",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1.1)),
                      const SizedBox(height: 4),
                      const Text("24 Trips Completed",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                      Text("Total distance: 140 km",
                          style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade400, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.green, size: 12),
                      SizedBox(width: 4),
                      Text("12%", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- 2. Weekly & Monthly Stats ---
          _buildModernHistoryItem("This Week", '168', '1,250 km', Icons.calendar_view_week_rounded),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 0.5),
          ),
          _buildModernHistoryItem("This Month", '672', '5,800 km', Icons.insert_invitation_rounded),

          const SizedBox(height: 25),

          // --- 3. PREMIUM FOOTER SECTION ---
          Row(
            children: [
              // Average Info (Left)
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), shape: BoxShape.circle),
                      child: const Icon(Icons.speed_rounded, color: Colors.orange, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Avg/Trip", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w700)),
                        Text("5.8 KM", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.w900, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),

              // NEW PREMIUM FULL REPORT BUTTON
              InkWell(
                onTap: () => Navigator.pushNamed(context, FleetManagerRoutes.tripHistory),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryTeal, primaryTeal.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: primaryTeal.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "FULL REPORT",
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.analytics_outlined, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(String val, double progress, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        Text(val, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
      ],
    );
  }

  Widget _buildModernHistoryItem(String title, String trips, String km, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey.shade300),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("$trips Trips", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
            Text(km, style: TextStyle(fontSize: 11, color: Colors.blueGrey.shade300, fontWeight: FontWeight.w500)),
          ],
        )
      ],
    );
  }
  Widget _buildHistoryItem(String label, String tripCount, String distance, bool isHighlight) {
    return Container(
      padding: EdgeInsets.all(isHighlight ? 16 : 12),
      decoration: BoxDecoration(
        color: isHighlight ? primaryTeal.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isHighlight ? primaryTeal.withOpacity(0.1) : Colors.transparent),
      ),
      child: Row(
        children: [
          // Mini Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isHighlight ? primaryTeal : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
                isHighlight ? Icons.speed : Icons.route_outlined,
                color: isHighlight ? Colors.white : Colors.grey,
                size: 16
            ),
          ),
          const SizedBox(width: 12),
          // Label
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                  color: isHighlight ? Colors.black87 : Colors.blueGrey.shade600,
                  fontSize: 14
              ),
            ),
          ),
          // Data points
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                distance,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF1E293B)),
              ),
              Text(
                "$tripCount Trips",
                style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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

  // --- Updated _routeSummaryCard with Progress Bars ---
  Widget _routeSummaryCard() {
    return _cardWrapper(
      title: 'Route Summary',
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.map_rounded, color: primaryTeal, size: 18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Route Items with modern progress bars ---
          _buildModernRouteItem('North Zone', 'Route 1', '45 Students', '2 Buses', 0.85, Colors.teal),
          const SizedBox(height: 16),
          _buildModernRouteItem('South Zone', 'Route 2', '52 Students', '2 Buses', 0.95, Colors.orange),
          const SizedBox(height: 16),
          _buildModernRouteItem('East Zone', 'Route 3', '28 Students', '1 Bus', 0.60, Colors.blue),

          const SizedBox(height: 25),

          // --- PREMIUM EXPLORE BUTTON ---
          InkWell(
            onTap: () => Navigator.pushNamed(context, FleetManagerRoutes.search),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC), // Light Slate Background
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EXPLORE ALL 8 ROUTES",
                    style: TextStyle(
                      color: primaryTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 16, color: primaryTeal),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// --- NEW MODERN ROUTE ITEM HELPER ---
  Widget _buildModernRouteItem(String zone, String routeCode, String students, String buses, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(zone, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                Text(routeCode, style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(students, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF334155))),
                Text(buses, style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Custom Slim Progress Bar
        Stack(
          children: [
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildRouteItem(String name, String students, String buses, double occupancy, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.near_me_rounded, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text("$students  •  $buses",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          // --- Occupancy Progress Bar ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Occupancy", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Text("${(occupancy * 100).toInt()}% Full",
                      style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: occupancy,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// --- Fixed _cardWrapper Function ---

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