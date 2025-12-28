import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_mock_data.dart';

class FleetSearchRoutes extends StatefulWidget {
  const FleetSearchRoutes({Key? key}) : super(key: key);

  @override
  State<FleetSearchRoutes> createState() => _FleetSearchRoutesState();
}

class _FleetSearchRoutesState extends State<FleetSearchRoutes> {
  final Color primaryTeal = const Color(0xFF0D9488);
  final Color secondaryIndigo = const Color(0xFF6366F1);
  final Color scaffoldBg = Colors.white;

  String _search = '';
  String _filterBy = 'Route'; // Toggle State
  int _bottomIndex = 1;

  void _onBottomTap(int index) {
    if (index == _bottomIndex) return;
    setState(() => _bottomIndex = index);
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, FleetManagerRoutes.home); break;
      case 2: Navigator.pushReplacementNamed(context, FleetManagerRoutes.tickets); break;
      case 3: Navigator.pushReplacementNamed(context, FleetManagerRoutes.moreOptions); break;
    }
  }

// --- 2. PREMIUM & ATTRACTIVE DETAIL SHEET ---
  void _showInfoSheet(String title, List<String> data, Color themeColor, IconData headerIcon) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        // Full width and responsive height
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.55,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD), // Ultra-light grey for premium feel
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 25, spreadRadius: 5)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Elegant Handle
            const SizedBox(height: 15),
            Container(
              width: 45, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 25),

            // --- HEADER SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [themeColor, themeColor.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))
                      ],
                    ),
                    child: Icon(headerIcon, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.5),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(6)),
                              child: Text("ACTIVE", style: TextStyle(color: Colors.green[700], fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            Text("${data.length} Total Records", style: TextStyle(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.grey[100],
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, color: Colors.black54, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(height: 1, thickness: 1.2, color: Color(0xFFF1F5F9)),

            // --- DATA LIST ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                itemCount: data.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // Letter Avatar with Gradient
                        Container(
                          height: 52, width: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: themeColor.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            data[i][0].toUpperCase(),
                            style: TextStyle(color: themeColor, fontWeight: FontWeight.w900, fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Information
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[i],
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Ref ID: AIS-DRV-0${i + 402}",
                                style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                              ),
                            ],
                          ),
                        ),
                        // Action Chip
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Icon(Icons.chevron_right_rounded, color: Color(0xFF64748B)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Small Helper for Sheet Actions
  Widget _sheetActionBtn(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = FleetMockData.routes.where((r) {
      final query = _search.trim().toLowerCase();
      if (query.isEmpty) return true;
      return _filterBy == 'Bus'
          ? (r.busNumber ?? '').toLowerCase().contains(query)
          : r.name.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildWhiteTopBar(),
            _buildCurvySearchSection(),
            const SizedBox(height: 25), // Spacing for floating search bar
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                physics: const BouncingScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  // Switch between Route Card and Bus Card based on filter
                  return _filterBy == 'Route'
                      ? _buildRouteCard(results[index])
                      : _buildBusCard(results[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: _onBottomTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryTeal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.local_activity_rounded), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildRouteCard(dynamic route) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 HEADER
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryTeal.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.route_rounded, color: primaryTeal, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Bus • ${route.busNumber ?? 'Not Assigned'}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "LIVE",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          /// 🔹 STATS (ONE LINE, BALANCED)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _routeMiniStat(Icons.groups_rounded, route.studentsCount.toString(), "Students"),
                _routeMiniStat(Icons.badge_rounded, route.driversCount.toString(), "Drivers"),
                _routeMiniStat(Icons.schedule_rounded, "45m", "Duration"),
              ],
            ),
          ),

          /// 🔹 ACTION BAR
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _actionBtn(
                    "STUDENTS",
                    Icons.groups_rounded,
                    primaryTeal,
                        () => _showInfoSheet(
                      "Route Students",
                      ["Rahul Sharma", "Sneha Kapoor", "Amit Verma"],
                      primaryTeal,
                      Icons.groups_rounded,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionBtn(
                    "DRIVERS",
                    Icons.badge_rounded,
                    secondaryIndigo,
                        () => _showInfoSheet(
                      "Route Drivers",
                      ["Vikram Singh", "Prakash Rao"],
                      secondaryIndigo,
                      Icons.badge_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeMiniStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey.shade400),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }


// --- Supporting Widgets ---

  Widget _fullWidthStat(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: color.withOpacity(0.8)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1E293B))),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _statDivider() {
    return Container(height: 30, width: 1, color: Colors.black.withOpacity(0.05));
  }

  Widget _premiumActionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 0.5)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: color.withOpacity(0.15), width: 1.5),
        ),
      ),
    );
  }
  // Helper for mini stats inside the card
  Widget _quickStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey.shade300),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF334155)),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
      ],
    );
  }

  // --- BUS SPECIFIC CARD ---
  // --- BUS SPECIFIC CARD (FIXED & UPDATED) ---
  Widget _buildBusCard(dynamic route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withOpacity(0.07)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Top Row: Bus ID & Status Badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.directions_bus_rounded, color: Colors.orange, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            route.busNumber ?? 'N/A',
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.circle, size: 8, color: Colors.green),
                              const SizedBox(width: 6),
                              Text(
                                "ON ROUTE",
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _miniFuelIndicator(65), // Custom Fuel indicator
                  ],
                ),

                const SizedBox(height: 20),

                // Stats Row: Bus Performance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _quickStat(Icons.speed_rounded, "42 km/h", "Speed"),
                    _quickStat(Icons.oil_barrel_rounded, "Good", "Engine"),
                    _quickStat(Icons.tire_repair_rounded, "Optimal", "Tyres"),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons Section (Fixed Arguments)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
              border: Border(top: BorderSide(color: Colors.black.withOpacity(0.04))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _actionBtn(
                    "HISTORY",
                    Icons.history_rounded, // Icon added
                    Colors.blueGrey,
                        () => _showInfoSheet(
                      "Service History",
                      ["Engine Oil (Nov 24)", "Brake Check (Oct 24)"],
                      Colors.blueGrey,
                      Icons.history_rounded, // ✅ ADD THIS
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionBtn(
                    "TRACK",
                    Icons.location_on_rounded, // Icon added
                    Colors.redAccent,
                    () => _showLiveTrackingSheet(route), // Sheet yahan se trigger hogi

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. PREMIUM LIVE TRACKING SHEET ---
  void _showLiveTrackingSheet(dynamic route) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),

            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tracking: ${route.busNumber}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      const Text("Status: On Time • Moving", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_fullscreen_rounded)),
                ],
              ),
            ),

            // --- FAKE MAP AREA ---
            Expanded(
              child: Stack(
                children: [
                  // Mock Map Image/Placeholder
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: NetworkImage('https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/-122.4241,37.78,14.25,0,60/600x600?access_token=YOUR_TOKEN_HERE'), // You can replace with a local asset map image
                        fit: BoxFit.cover,
                        opacity: 0.6,
                      ),
                    ),
                  ),

                  // Pulsing Bus Icon (Animation look)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: primaryTeal,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [BoxShadow(color: primaryTeal.withOpacity(0.4), blurRadius: 20, spreadRadius: 10)],
                          ),
                          child: const Icon(Icons.directions_bus_rounded, color: Colors.white, size: 30),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                          child: const Text("Current Location", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),

                  // Floating Info Cards (ETA & Distance)
                  Positioned(
                    bottom: 30,
                    left: 40,
                    right: 40,
                    child: Row(
                      children: [
                        _trackInfoCard("ETA", "14 MIN", Icons.timer_outlined, Colors.orange),
                        const SizedBox(width: 15),
                        _trackInfoCard("DIST", "3.2 KM", Icons.map_outlined, Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Action
            Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone_in_talk_rounded, color: Colors.white),
                label: const Text("CONTACT DRIVER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackInfoCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Chota Fuel indicator for top right
  Widget _miniFuelIndicator(int percent) {
    return Column(
      children: [
        Icon(Icons.local_gas_station_rounded, size: 16, color: Colors.grey.shade400),
        Text("$percent%", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
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

  Widget _buildCurvySearchSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF0F766E), Color(0xFF14B8A6)]),
            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(450, 80)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explorer: $_filterBy', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          _smallFilterBtn('Route'),
                          _smallFilterBtn('Bus'),
                        ],
                      ),
                    ),
                  ],
                ),
                Text('Manage your fleet ${_filterBy.toLowerCase()}s', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -15,
          left: 20,
          right: 20,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.08)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: TextField(
              onChanged: (val) => setState(() => _search = val),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded, color: primaryTeal, size: 22),
                hintText: 'Search for ${_filterBy.toLowerCase()}...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _smallFilterBtn(String label) {
    bool isSelected = _filterBy == label;
    return GestureDetector(
      onTap: () => setState(() => _filterBy = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(color: isSelected ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Text(label, style: TextStyle(color: isSelected ? primaryTeal : Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _actionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08), // Light Background
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2), width: 1.5), // Subtle Border
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color), // Icon for visual cue
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}