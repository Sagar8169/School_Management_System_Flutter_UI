import 'package:flutter/material.dart';

class FleetTripHistoryPage extends StatefulWidget {
  const FleetTripHistoryPage({Key? key}) : super(key: key);

  @override
  State<FleetTripHistoryPage> createState() => _FleetTripHistoryPageState();
}

class _FleetTripHistoryPageState extends State<FleetTripHistoryPage> {
  String selectedFilter = 'Weekly';
  final Color primaryTeal = const Color(0xFF0F766E); // Deep Teal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Light Slate background
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Summary Cards (Premium Gradient) ---
            _buildPremiumHeader(),

            // --- 2. Filter Section ---
            _buildInteractiveFilters(),

            // --- 3. Chart Section ---
            _buildEnhancedChart(),

            // --- 4. Section Title ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: primaryTeal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "RECENT TRIP LOGS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF475569),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.sort_rounded, size: 20, color: primaryTeal),
                ],
              ),
            ),

            // --- 5. List of Logs ---
            _buildModernTripList(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Operational Reports',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share_outlined, color: primaryTeal, size: 20),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildPremiumHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
      child: Row(
        children: [
          _summaryBox("672", "Trips", Icons.map_rounded, Colors.blue),
          _divider(),
          _summaryBox("5.8k", "KM", Icons.speed_rounded, Colors.orange),
          _divider(),
          _summaryBox("98%", "Safe", Icons.shield_rounded, Colors.green),
        ],
      ),
    );
  }

  Widget _summaryBox(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color.withOpacity(0.8), size: 22),
          const SizedBox(height: 8),
          Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.blueGrey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _divider() => Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.2));

  Widget _buildInteractiveFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: ['Daily', 'Weekly', 'Monthly', 'Quarterly'].map((filter) {
          bool isSelected = selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? primaryTeal : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: isSelected
                    ? [BoxShadow(color: primaryTeal.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                    : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEnhancedChart() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryTeal, primaryTeal.withBlue(100)],
          begin: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: primaryTeal.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Operational Trend", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Icon(Icons.auto_graph_rounded, color: Colors.white.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [30, 50, 80, 40, 90, 70, 100].map((h) => Column(
              children: [
                Container(
                  width: 14,
                  height: h.toDouble(),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(h > 80 ? 1 : 0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            )).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((d) => Text(d, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold))).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildModernTripList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Row(
            children: [
              // Shift Icon with dynamic color
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: primaryTeal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.directions_bus_filled_rounded, color: primaryTeal, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Route ${10 + index} • Morning", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF0F172A))),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person_pin, size: 12, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text("Driver ID: #DRV${88 + index}", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("12.4 KM", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF0F172A))),
                  const SizedBox(height: 6),
                  _statusChip(index % 3 == 0 ? "Delayed" : "On Time"),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _statusChip(String status) {
    bool isDelayed = status == "Delayed";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDelayed ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isDelayed ? Colors.red : Colors.green,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}