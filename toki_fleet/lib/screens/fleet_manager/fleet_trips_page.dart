import 'package:flutter/material.dart';

// 1. State maintain karne ke liye ise StatefulWidget banaya gaya hai
class FleetTripsPage extends StatefulWidget {
  final String shift;
  const FleetTripsPage({Key? key, required this.shift}) : super(key: key);

  @override
  State<FleetTripsPage> createState() => _FleetTripsPageState();
}

class _FleetTripsPageState extends State<FleetTripsPage> {
  static const Color primaryTeal = Color(0xFF0D9488);
  static const Color slateBlue = Color(0xFF1E293B);

  // Filter state variable
  String selectedFilter = "All";

// ... (Baki import aur class setup same rahega)

  @override
  Widget build(BuildContext context) {
    // Logic for filtering
    List<int> busIndices = List.generate(10, (index) => index + 1);
    List<int> filteredBuses = busIndices.where((busNum) {
      bool isDelayed = busNum % 3 == 0;
      if (selectedFilter == "Delayed") return isDelayed;
      if (selectedFilter == "Moving") return !isDelayed;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildOriginalHeader(context), // Ab ye header clean hai

          // --- NAYA LIVE STATS SECTION ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: _premiumStatCard(
                    Icons.directions_bus_filled_rounded,
                    "8",
                    "Active Buses",
                    const Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _premiumStatCard(
                    Icons.people_alt_rounded,
                    "342",
                    "Students",
                    const Color(0xFF16A34A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _premiumStatCard(
                    Icons.timer_rounded,
                    "12 min",
                    "Avg Delay",
                    const Color(0xFFF97316),
                  ),
                ),
              ],
            ),
          ),

          // --- FILTER SECTION ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip("All"),
                  const SizedBox(width: 8),
                  _filterChip("Moving"),
                  const SizedBox(width: 8),
                  _filterChip("Delayed"),
                ],
              ),
            ),
          ),

          Expanded(
            child: filteredBuses.isEmpty
                ? const Center(child: Text("No buses found"))
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              itemCount: filteredBuses.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _buildTripCard(context, filteredBuses[index]),
            ),
          ),
        ],
      ),
    );
  }

  // Naya Stat Item Widget
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
          ),
          child: Icon(icon, color: primaryTeal, size: 20),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: slateBlue)),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade500, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // --- CLEAN HEADER ---
  Widget _buildOriginalHeader(BuildContext context) {
    return Container(
      height: 90, // Height thodi kam kar di kyunki info niche shift ho gayi
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              Text(
                widget.shift,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Baki saare filter chips aur cards ka code same rahega)
  // Filter Chip Widget
  Widget _filterChip(String label) {
    bool isSelected = selectedFilter == label;

    // Label ke hisaab se icon aur color decide karna
    IconData chipIcon;
    Color activeColor;

    switch (label) {
      case "Moving":
        chipIcon = Icons.bolt_rounded;
        activeColor = const Color(0xFF0D9488); // Teal
        break;
      case "Delayed":
        chipIcon = Icons.warning_amber_rounded;
        activeColor = Colors.orange.shade700;
        break;
      default:
        chipIcon = Icons.apps_rounded;
        activeColor = const Color(0xFF1E293B); // Slate
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () => setState(() => selectedFilter = label),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            // Subtle border jab select na ho
            border: Border.all(
              color: isSelected ? activeColor : Colors.grey.withOpacity(0.2),
              width: 1.5,
            ),
            // Deep shadow effect for selection
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: activeColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                chipIcon,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _premiumStatCard(
      IconData icon,
      String value,
      String label,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // --- AAPKA BAKI CODE (Unchanged) ---
  Widget _buildTripCard(BuildContext context, int busNum) {
    bool isDelayed = busNum % 3 == 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: slateBlue.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                _buildBusStatusIcon(isDelayed),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bus AIS-10$busNum", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: slateBlue)),
                      const SizedBox(height: 4),
                      Text(
                        isDelayed ? "● Delayed (8m)" : "● Moving • On Time",
                        style: TextStyle(color: isDelayed ? Colors.red : primaryTeal, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _buildSimulateBtn(context, busNum),
                const SizedBox(width: 8),
                _iconBtn(Icons.call_rounded, Colors.green, () => _showDriverContact(context, busNum)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
            child: _buildTripProgress(busNum),
          ),
        ],
      ),
    );
  }

  // ... (Baki saare functions: _buildBusStatusIcon, _buildSimulateBtn, _runSimulationEffect, _iconBtn, _buildTripProgress, _stopLabel, _showDriverContact, _contactItem - same rahenge)

  Widget _buildBusStatusIcon(bool isDelayed) {
    return Container(
      height: 50, width: 50,
      decoration: BoxDecoration(color: isDelayed ? Colors.red.withOpacity(0.08) : primaryTeal.withOpacity(0.08), shape: BoxShape.circle),
      child: Icon(Icons.directions_bus_filled_rounded, color: isDelayed ? Colors.red : primaryTeal, size: 24),
    );
  }

  Widget _buildSimulateBtn(BuildContext context, int busNum) {
    return GestureDetector(
      onTap: () => _runSimulationEffect(context, busNum),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: const Row(
          children: [
            Icon(Icons.refresh_rounded, size: 14, color: Colors.blue),
            SizedBox(width: 4),
            Text("LIVE", style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  void _runSimulationEffect(BuildContext context, int busNum) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: primaryTeal, strokeWidth: 3),
                const SizedBox(height: 15),
                Text("Syncing Bus #$busNum GPS...", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _iconBtn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _buildTripProgress(int index) {
    double progress = 0.3 + (index * 0.05);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _stopLabel("START", true),
            _stopLabel("IN TRANSIT", progress > 0.4),
            _stopLabel("DROP", false),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(height: 6, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10))),
            FractionallySizedBox(
              widthFactor: progress > 1.0 ? 1.0 : progress,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [primaryTeal, Color(0xFF2DD4BF)]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _stopLabel(String label, bool isReached) {
    return Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: isReached ? slateBlue : Colors.grey[400]));
  }

  void _showDriverContact(BuildContext context, int busNum) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Contact Personnel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: slateBlue)),
            const SizedBox(height: 20),
            _contactItem("Vikram Singh", "Driver", "7014XXXXXX"),
            const Divider(height: 20),
            _contactItem("Savitri Devi", "Attendant", "9829XXXXXX"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _contactItem(String name, String role, String phone) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: primaryTeal.withOpacity(0.1), child: const Icon(Icons.person, color: primaryTeal)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(role),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: Colors.green)),
    );
  }
}