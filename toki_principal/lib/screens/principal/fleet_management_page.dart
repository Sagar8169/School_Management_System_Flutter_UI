import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class FleetManagementPage extends StatefulWidget {
  const FleetManagementPage({Key? key}) : super(key: key);

  @override
  _FleetManagementPageState createState() => _FleetManagementPageState();
}

class _FleetManagementPageState extends State<FleetManagementPage> {
  // int _currentIndex = 0;
  bool _isTelugu = false;
  String _selectedFilter = 'All Vehicles';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _allVehicles = [
    {
      'vehicleNumber': 'AP-07-AB-1234',
      'vehicleType': 'School Bus',
      'driver': 'Mr. Rajesh Kumar',
      'capacity': 40,
      'status': 'Active',
      'route': 'Route A',
      'currentLocation': 'Main Gate',
      'nextPickup': '8:30 AM',
    },
    {
      'vehicleNumber': 'AP-07-CD-5678',
      'vehicleType': 'Mini Bus',
      'driver': 'Mr. Suresh Reddy',
      'capacity': 25,
      'status': 'On Trip',
      'route': 'Route B',
      'currentLocation': 'Suburbs',
      'nextPickup': '9:00 AM',
    },
    {
      'vehicleNumber': 'AP-07-EF-9012',
      'vehicleType': 'School Bus',
      'driver': 'Mrs. Anitha Sharma',
      'capacity': 35,
      'status': 'Maintenance',
      'route': 'Route C',
      'currentLocation': 'Workshop',
      'nextPickup': 'N/A',
    },
  ];

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushReplacementNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Slate background for premium feel
      body: Column(
        children: [
          // ✨ APP BAR SECTION
          _buildBrandingHeader(),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // ✨ MODERN GREEN HERO SECTION
                  _buildModernHero(),

                  const SizedBox(height: 24),

                  // ✨ INTERACTIVE FILTERS
                  _buildModernFilterBar(),

                  const SizedBox(height: 10),

                  // ✨ COMPACT PREMIUM CARDS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: _allVehicles
                          .where((v) {
                            // Yahan 'All' check karna zaroori hai kyunki filter bar mein label 'All' hai
                            if (_selectedFilter == 'All' ||
                                _selectedFilter == 'All Vehicles') {
                              return true;
                            }
                            return v['vehicleType'] == _selectedFilter;
                          })
                          .map((v) => _buildUltraModernCard(v))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 100), // Spacing for FAB/Bottom
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBrandingHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 10,
        20,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6), // 👈 shadow only at bottom
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔙 Circular Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF334155),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 🚚 Title
          const Expanded(
            child: Text(
              "Fleet Management",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
          ),

          // 🌐 Language Chip
          _buildLanguageChip(),
        ],
      ),
    );
  }

  Widget _buildLanguageChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
          color: const Color(0xFFECFDF5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD1FAE5))),
      child: Text(_isTelugu ? "తెలుగు" : "English",
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFF059669))),
    );
  }

  Widget _buildModernHero() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        // --- DEEP EMERALD GRADIENT ---
        gradient: const LinearGradient(
          colors: [Color(0xFF064E3B), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // --- SUBTLE BACKGROUND DECORATION ---
            Positioned(
              right: -20,
              top: -20,
              child: Icon(Icons.map_rounded,
                  size: 150, color: Colors.white.withOpacity(0.05)),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.sensors_rounded,
                                color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "FLEET OVERVIEW",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text("LIVE",
                            style: TextStyle(
                                color: Color(0xFF34D399),
                                fontSize: 9,
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // --- GLASS STATS PANEL ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.15), width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _heroStat(
                            "04", "Vehicles", Icons.local_shipping_rounded),
                        _heroDivider(),
                        _heroStat("03", "On Road", Icons.route_rounded),
                        _heroDivider(),
                        _heroStat(
                            "115", "Total Seats", Icons.event_seat_rounded),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Compact Stats with Icons
  Widget _heroStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.6), size: 16),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5),
        ),
        Text(
          label.toUpperCase(),
          style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5),
        ),
      ],
    );
  }

  Widget _heroDivider() {
    return Container(
        height: 35, width: 1.5, color: Colors.white.withOpacity(0.1));
  }

  Widget _verticalDivider() =>
      Container(height: 30, width: 1, color: Colors.white24);

  Widget _buildModernFilterBar() {
    final filters = [
      {'label': 'All', 'icon': Icons.grid_view_rounded},
      {'label': 'School Bus', 'icon': Icons.directions_bus_rounded},
      {'label': 'Mini Bus', 'icon': Icons.bus_alert_rounded},
      {'label': 'Van', 'icon': Icons.airport_shuttle_rounded},
    ];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (ctx, i) {
          final filter = filters[i];
          bool sel = _selectedFilter == filter['label'];

          return GestureDetector(
            onTap: () =>
                setState(() => _selectedFilter = filter['label'] as String),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: sel ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                // --- PREMIUM BORDER & SHADOW ---
                border: Border.all(
                  color:
                      sel ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                boxShadow: sel
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Icon(
                    filter['icon'] as IconData,
                    size: 16,
                    color: sel ? Colors.white : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    filter['label'] as String,
                    style: TextStyle(
                      color: sel ? Colors.white : const Color(0xFF475569),
                      fontWeight: sel ? FontWeight.w900 : FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showVehicleDetails(BuildContext context, Map<String, dynamic> v) {
    Color statusColor = v['status'] == 'Active'
        ? const Color(0xFF10B981)
        : (v['status'] == 'On Trip'
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height *
            0.82, // Thodi height badhai for better spacing
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC), // Slate Background
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            // --- 1. PREMIUM HEADER ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Container(
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10))),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(Icons.local_shipping_rounded,
                              color: statusColor, size: 24),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(v['vehicleNumber'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5)),
                            _statusBadge(v['status'], statusColor),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.cancel_rounded,
                              color: Color(0xFFCBD5E1), size: 30),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 2. DRIVER SPOTLIGHT CARD ---
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: const Color(0xFFF1F5F9),
                            child: Icon(Icons.person_3_rounded,
                                color: Colors.blue.shade800, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("DRIVER IN CHARGE",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF94A3B8),
                                        letterSpacing: 1)),
                                Text(v['driver'],
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF0F172A))),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star_rounded,
                                        size: 14,
                                        color: Colors.orange.shade400),
                                    const SizedBox(width: 4),
                                    const Text("4.8 Rating",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF64748B))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.call_rounded,
                                color: Color(0xFF10B981), size: 20),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // --- 3. TRIP TRACKING SECTION ---
                    const Text("CURRENT TRIP STATUS",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 1.2)),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFE2E8F0))),
                      child: Column(
                        children: [
                          _buildTrackRow(Icons.radio_button_checked_rounded,
                              "Current Location", v['currentLocation'],
                              isLast: false, color: statusColor),
                          const SizedBox(height: 20),
                          _buildTrackRow(Icons.location_on_rounded,
                              "Assigned Route", v['route'],
                              isLast: true, color: Colors.blue.shade700),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // --- 4. QUICK STATS TILES ---
                    Row(
                      children: [
                        _buildInfoTile("CAPACITY", v['capacity'].toString(),
                            Icons.airline_seat_recline_extra_rounded),
                        const SizedBox(width: 12),
                        _buildInfoTile(
                            "PICKUP", v['nextPickup'], Icons.timer_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // --- 5. ACTION FOOTER ---
            Container(
              padding: EdgeInsets.fromLTRB(
                  24, 20, 24, MediaQuery.of(context).padding.bottom + 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.gps_fixed_rounded,
                          color: Colors.white, size: 20),
                      label: const Text("LIVE TRACKING",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper: Custom Tracking Row
  Widget _buildTrackRow(IconData icon, String label, String value,
      {required bool isLast, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: color, size: 22),
            if (!isLast)
              Container(width: 2, height: 30, color: const Color(0xFFE2E8F0)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF94A3B8))),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B))),
            ],
          ),
        ),
      ],
    );
  }

// Helper: Action Info Tile
  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: const Color(0xFF64748B)),
            const SizedBox(height: 12),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF94A3B8))),
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B))),
          ],
        ),
      ),
    );
  }

// --- 2. UPDATED TAPPABLE CARD ---
  Widget _buildUltraModernCard(Map<String, dynamic> data) {
    Color statusColor = data['status'] == 'Active'
        ? const Color(0xFF10B981)
        : (data['status'] == 'On Trip'
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444));

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () => _showVehicleDetails(context, data),
          child: Column(
            children: [
              // Top Plate Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0))),
                      child: Row(
                        children: [
                          const Icon(Icons.tag_rounded,
                              size: 12, color: Color(0xFF64748B)),
                          const SizedBox(width: 4),
                          Text(data['vehicleNumber'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  letterSpacing: 0.5)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    _statusBadge(data['status'], statusColor),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Driver Box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(
                            data['vehicleType'] == 'School Bus'
                                ? Icons.directions_bus_rounded
                                : Icons.airport_shuttle_rounded,
                            color: statusColor,
                            size: 26),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['driver'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0F172A))),
                            Text(data['vehicleType'],
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: Color(0xFF94A3B8)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Bottom Metrics
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _metricPill(Icons.alt_route_rounded, data['route'],
                        const Color(0xFF6366F1)),
                    _metricPill(Icons.my_location_rounded,
                        data['currentLocation'], const Color(0xFF0EA5E9)),
                    _metricPill(Icons.groups_rounded, "${data['capacity']}",
                        const Color(0xFF64748B)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// --- 3. HELPER WIDGETS ---
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF64748B)),
          const SizedBox(width: 15),
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B))),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B))),
        ],
      ),
    );
  }

  Widget _metricPill(IconData icon, String val, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(val,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF475569))),
        ],
      ),
    );
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 1)
                ]),
          ),
          const SizedBox(width: 8),
          Text(label.toUpperCase(),
              style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8)),
        ],
      ),
    );
  }

  Widget _metricRow(IconData icon, String val) => Row(children: [
        Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 6),
        Text(val,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B))),
      ]);

  // Widget _buildBottomNav() {
  //   return Container(
  //     decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex, onTap: _onBottomNavTap,
  //       type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
  //       selectedItemColor: themeBlue,
  //       unselectedItemColor: const Color(0xFF94A3B8),        elevation: 0, items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home_rounded),
  //         label: "Home",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search_rounded),
  //         label: "Search",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.analytics_rounded),
  //         label: "Activity",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.grid_view_rounded),
  //         label: "More",
  //       ),
  //     ],
  //     ),
  //   );
  // }
}
