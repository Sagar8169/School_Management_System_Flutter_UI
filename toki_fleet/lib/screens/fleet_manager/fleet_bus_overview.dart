import 'package:flutter/material.dart';

class FleetBusOverview extends StatefulWidget {
  const FleetBusOverview({Key? key}) : super(key: key);

  @override
  State<FleetBusOverview> createState() => _FleetBusOverviewState();
}

class _FleetBusOverviewState extends State<FleetBusOverview> {
  final Color primaryTeal = const Color(0xFF0D9488);

  // --- DUMMY WORKING: SHOW INFO SHEETS ---
  void _showActionSheet(String title, List<String> details, IconData icon, Color color) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              ],
            ),
            const Divider(height: 30),
            ...details.map((d) => ListTile(
              leading: Icon(Icons.check_circle_outline_rounded, color: color, size: 20),
              title: Text(d, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              contentPadding: EdgeInsets.zero,
            )).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- DUMMY WORKING: TRACKING SHEET ---
  void _showTrackSheet(String busNo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),

            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: Colors.blue, size: 26),
                  const SizedBox(width: 12),
                  Text(
                    "Live Tracking • $busNo",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            /// Fake Map Area
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.grey.shade200,
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("Live map loading...",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone, color: Colors.white),
            label: const Text(
              "CALL DRIVER",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white, // ✅ text white
                letterSpacing: 1.1,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white, // ✅ safety for ripple & text
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),

      ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: 6,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _buildDetailedBusCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Fleet Overview', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                ],
              ),
              const SizedBox(height: 18),
              _buildSearchBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search bus number or route...",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: primaryTeal),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDetailedBusCard(int index) {
    String busNo = "AP09-T-123$index";
    bool isService = index == 3;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          _cardTopSection(busNo, index, isService),
          const Divider(height: 1, indent: 20, endIndent: 20),
          _cardHealthStats(),
          _cardActionFooter(busNo),
        ],
      ),
    );
  }

  Widget _cardTopSection(String busNo, int index, bool isService) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isService ? Colors.red.withOpacity(0.1) : primaryTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(Icons.directions_bus_rounded, color: isService ? Colors.red : primaryTeal, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(busNo, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                Text("Route: Jubilee Hills • $index km away",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          _statusBadge(isService),
        ],
      ),
    );
  }

  Widget _cardHealthStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _miniHealthStat(Icons.local_gas_station_rounded, "65%", "Fuel", Colors.orange),
          _miniHealthStat(Icons.speed_rounded, "42km/h", "Speed", Colors.blue),
          _miniHealthStat(Icons.people_alt_rounded, "32/40", "Load", Colors.purple),
        ],
      ),
    );
  }

  Widget _cardActionFooter(String busNo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        children: [
          /// 📍 TRACK
          _footerAction(
            Icons.location_on_rounded,
            "Track",
            Colors.blue,
                () => _showTrackSheet(busNo),
          ),

          /// 🕘 HISTORY
          _footerAction(
            Icons.history_rounded,
            "History",
            Colors.blueGrey,
                () => _showPremiumSheet(
              title: "Service History",
              items: [
                "Engine Oil (Nov 24)",
                "Brake Check (Oct 24)",
                "Tyre Rotation (Sept 24)",
              ],
              icon: Icons.history_rounded,
              color: Colors.blueGrey,
            ),
          ),

          /// ℹ️ DETAILS
          _footerAction(
            Icons.info_outline_rounded,
            "Details",
            primaryTeal,
                () => _showPremiumSheet(
              title: "Vehicle Details",
              items: [
                "Model: Tata Starbus",
                "Capacity: 40 Seats",
                "Year: 2023",
                "Insurance Valid",
              ],
              icon: Icons.info_outline_rounded,
              color: primaryTeal,
            ),
          ),
        ],
      ),
    );
  }

  void _showPremiumSheet({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color color,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// Drag Handle
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 24),

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "${items.length} records",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade200),

            /// CONTENT
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          items[i][0],
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          items[i],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _statusBadge(bool isService) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isService ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(isService ? "SERVICE" : "ON ROUTE",
          style: TextStyle(color: isService ? Colors.red : Colors.green, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }

  Widget _miniHealthStat(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Row(children: [Icon(icon, size: 14, color: color), const SizedBox(width: 4), Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13))]),
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 9, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _footerAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icon, size: 14, color: color), const SizedBox(width: 6), Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800))],
          ),
        ),
      ),
    );
  }
}