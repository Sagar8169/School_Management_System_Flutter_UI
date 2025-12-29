import 'package:flutter/material.dart';
import 'package:toki/routes/driver_routes.dart';
import 'package:toki/widgets/driver_widgets.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  bool _showAlert = true;
  bool _isTelugu = true;
  @override
  Widget build(BuildContext context) {
    final double px = MediaQuery.of(context).size.width > 600 ? 40.0 : 15.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ✨ App Header (Original Logic)
            DriverWidgets.appHeader(
              schoolName: 'Aditya International School',
              schoolInitial: 'A',
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: () => setState(() => _isTelugu = !_isTelugu),
            ),

            Expanded(
              child: RefreshIndicator(
                color: DriverWidgets.primaryColor,
                onRefresh: () async =>
                    await Future.delayed(const Duration(seconds: 1)),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: px),
                  children: [
                    const SizedBox(height: 16),

                    // 1. Driver Profile Hero (Premium Gradient)
                    _buildDriverHero(),

                    const SizedBox(height: 16),

                    // 2. Alert Banner (Logic preserved)
                    if (_showAlert)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _premiumAlertBanner(
                          title: 'Cyclone Alert - School Closed',
                          message:
                              'Due to severe cyclone warning, school remains closed. Stay safe!',
                          onDismiss: () => setState(() => _showAlert = false),
                        ),
                      ),

                    // 3. Merged Dashboard (Trips & Stats)
                    _buildCombinedDashboardCard(context),

                    const SizedBox(height: 28),

                    // 4. My Route Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My Route', style: DriverWidgets.titleLarge()),
                        const Text('AP09T1234',
                            style: TextStyle(
                                color: DriverWidgets.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildRouteCard(context),

                    const SizedBox(height: 28),

                    // 5. Recent Trips Section
                    Text('Recent Trips', style: DriverWidgets.titleLarge()),
                    const SizedBox(height: 12),

                    _buildRecentTripCard(
                      date: 'Today - Morning',
                      status: 'Completed',
                      stops: '4/4',
                      distance: '25 km',
                      onTap: () => Navigator.pushNamed(
                          context, DriverRoutes.tripCompleted,
                          arguments: {'tripId': 'TRIP-001'}),
                    ),

                    const SizedBox(height: 12),

                    _buildRecentTripCard(
                      date: 'Todays - Evening',
                      status: 'Ongoing',
                      stops: '4/4',
                      distance: '24 km',
                      onTap: () => Navigator.pushNamed(
                          context, DriverRoutes.tripDetail,
                          arguments: {'tripId': 'TRIP-002'}),
                    ),

                    const SizedBox(height: 40), // Bottom Buffer
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _premiumAlertBanner({
    required String title,
    required String message,
    required VoidCallback onDismiss,
  }) {
    return Container(
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
          /// 🚨 Icon
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

          /// 📄 Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// ❌ Close
          GestureDetector(
            onTap: onDismiss,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFEF6C00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFE65100).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('THURSDAY, OCT 30',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1)),
          const SizedBox(height: 12),
          Text('Krishna Murthy',
              style: DriverWidgets.headlineMedium(color: Colors.white)),
          Text('Senior Fleet Operator',
              style: DriverWidgets.bodyMedium(
                  color: Colors.white.withOpacity(0.9))),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.directions_bus_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text('Route 1 • Banjara Hills',
                  style: DriverWidgets.bodyMedium(color: Colors.white)
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCombinedDashboardCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB), // Premium Blue
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Trips",
                          style: DriverWidgets.bodySmall(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '2 Total',
                          style: DriverWidgets.headlineLarge(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    /// 📅 Calendar (dummy functional)
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => _openCalendar(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _tripStatusBtn(
                      context,
                      'Morning',
                      'Live',
                      true,
                    ),
                    const SizedBox(width: 12),
                    _tripStatusBtn(context, 'Evening', 'Pending', false),
                  ],
                ),
              ],
            ),
          ),

          /// 🔹 Bottom stats strip
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 22,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _miniHeroStat(Icons.show_chart, 'Trips', '1'),
                Container(width: 1, height: 30, color: Colors.white10),
                _miniHeroStat(Icons.speed, 'Distance', '25 km'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openCalendar(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Widget _tripStatusBtn(
      BuildContext context, String time, String status, bool isLive) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, DriverRoutes.tripDetail,
            arguments: {'tripId': isLive ? 'TRIP-CURRENT' : 'TRIP-EVENING'}),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLive ? Colors.white : Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: TextStyle(
                      color: isLive ? const Color(0xFF2563EB) : Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(status,
                  style: TextStyle(
                      color: isLive ? const Color(0xFF1E293B) : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 🔶 Modern Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFE65100), Colors.orange.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.map_rounded,
                      color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Route 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Banjara Hills • Morning Shift',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Simulation Start Button
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                      context, DriverRoutes.tripDetail,
                      arguments: {'tripId': 'TRIP-LIVE-01'}),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFE65100),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('START',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                ),
              ],
            ),
          ),

          /// 🗺 High-End Timeline Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
            child: Column(
              children: [
                _buildModernTimelineItem(1, 'Banjara Hills Circle', '07:30 AM',
                    isFirst: true, isCrossed: true),
                _buildModernTimelineItem(
                    2, 'Jubilee Hills Checkpost', '07:45 AM',
                    isCrossed: true),
                _buildModernTimelineItem(3, 'Road No 10 Hub', '08:00 AM',
                    isCurrent: true),
                _buildModernTimelineItem(4, 'DPS Main School', '08:15 AM',
                    isLast: true),
              ],
            ),
          ),

          /// 🚌 Bus Info Footer
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(Icons.directions_bus_filled_rounded, 'AP09T1234'),
                _infoTile(Icons.people_alt_rounded, '32 Students'),
                _infoTile(Icons.speed_rounded, '24 KM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Modern Timeline Item Helper
  Widget _buildModernTimelineItem(int index, String title, String time,
      {bool isFirst = false,
      bool isLast = false,
      bool isCrossed = false,
      bool isCurrent = false}) {
    Color dotColor = isCrossed
        ? Colors.green
        : (isCurrent ? const Color(0xFFE65100) : Colors.grey.shade300);

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCurrent ? Colors.white : dotColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotColor, width: isCurrent ? 6 : 2),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                              color: dotColor.withOpacity(0.3), blurRadius: 10)
                        ]
                      : null,
                ),
                child: isCrossed
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isCrossed ? Colors.green : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isCurrent ? FontWeight.w900 : FontWeight.w700,
                        color: isCurrent
                            ? Colors.black
                            : (isCrossed ? Colors.black87 : Colors.grey),
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: isCurrent
                          ? const Color(0xFFE65100)
                          : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blueGrey),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.blueGrey)),
      ],
    );
  }

  Widget _miniHeroStat(IconData icon, String label, String val) {
    return Row(children: [
      Icon(icon, color: Colors.white70, size: 18),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold)),
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900)),
      ]),
    ]);
  }

  Widget _buildTimelineItem(
    int index,
    String location,
    String time, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🟠 Timeline Indicator
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                border: Border.all(
                  color: const Color(0xFFE65100),
                  width: 2,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Color(0xFFE65100),
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            /// ⬇️ Connector
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),

        const SizedBox(width: 16),

        /// 📍 Stop Details
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: DriverWidgets.bodyMedium().copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: DriverWidgets.bodySmall().copyWith(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTripCard({
    required String date,
    required String status,
    required String stops,
    required String distance,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: DriverWidgets.card(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 🔹 Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 📅 Date + Location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: DriverWidgets.titleMedium().copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Banjara Hills',
                            style: DriverWidgets.bodySmall().copyWith(
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// 🟢 Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: status == 'Completed'
                        ? const Color(0xFFF0FDF4)
                        : const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status == 'Completed'
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFEA580C),
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// 🔹 Stats + CTA
            Row(
              children: [
                _tripStat(Icons.stop_circle_outlined, stops),
                const SizedBox(width: 22),
                _tripStat(Icons.speed_rounded, distance),
                const Spacer(),
                const Row(
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: DriverWidgets.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: DriverWidgets.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tripStat(IconData icon, String val) => Row(children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        Text(val, style: DriverWidgets.bodySmall())
      ]);
}
