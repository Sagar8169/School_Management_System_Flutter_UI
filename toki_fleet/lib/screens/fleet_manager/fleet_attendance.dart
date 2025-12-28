import 'package:flutter/material.dart';

class FleetAttendance extends StatefulWidget {
  const FleetAttendance({Key? key}) : super(key: key);

  @override
  State<FleetAttendance> createState() => _FleetAttendanceState();
}

class _FleetAttendanceState extends State<FleetAttendance> {
  static const primaryGreen = Color(0xFF10B981);
  static const primaryIndigo = Color(0xFF6366F1);

  // Filter Logic
  String _selectedFilter = "All";

  // Mock Data
  final List<Map<String, dynamic>> _drivers = List.generate(10, (index) => {
    "name": "Driver Name ${index + 1}",
    "id": "DRV-10${index + 1}",
    "time": "07:${10 + index} AM",
    "status": index == 3 || index == 7 ? "Absent" : "Present",
    "bus": "AP09-T-123${index}",
    "route": "Route ${index + 1}",
    "phone": "+91 98765 4321$index",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Attendance Report", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOverviewCard(),
                  const SizedBox(height: 24),
                  _buildFilterTabs(), // Filter Section
                  const SizedBox(height: 16),
                  _buildAttendanceList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- FILTER TABS ---
  Widget _buildFilterTabs() {
    return Row(
      children: ["All", "Present", "Absent"].map((filter) {
        bool isSelected = _selectedFilter == filter;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (val) => setState(() => _selectedFilter = filter),
            selectedColor: primaryIndigo.withOpacity(0.1),
            labelStyle: TextStyle(color: isSelected ? primaryIndigo : Colors.grey, fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide(color: isSelected ? primaryIndigo : Colors.grey.shade200),
          ),
        );
      }).toList(),
    );
  }

  // --- DRIVER DETAIL BOTTOM SHEET ---
  void _showDriverDetails(Map<String, dynamic> driver) {
    bool isPresent = driver['status'] == "Present";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Glass effect ke liye transparent
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),

              // Profile & Status Header
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: isPresent ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        child: Icon(
                            isPresent ? Icons.person_rounded : Icons.person_off_rounded,
                            size: 38,
                            color: isPresent ? Colors.green : Colors.red
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                              Icons.circle,
                              color: isPresent ? Colors.green : Colors.red,
                              size: 14
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            driver['name'],
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))
                        ),
                        Text(
                            "Driver ID: ${driver['id']}",
                            style: const TextStyle(color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Information Grid (2x2 Style)
              Row(
                children: [
                  _infoCard(Icons.access_time_filled_rounded, "Reporting", driver['time'], Colors.blue),
                  const SizedBox(width: 12),
                  _infoCard(Icons.directions_bus_rounded, "Bus No.", driver['bus'], Colors.orange),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _infoCard(Icons.map_rounded, "Route", driver['route'], Colors.purple),
                  const SizedBox(width: 12),
                  _infoCard(Icons.phone_iphone_rounded, "Contact", "Tap to Call", Colors.green),
                ],
              ),

              const SizedBox(height: 30),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text("Close"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Dummy call logic
                      },
                      icon: const Icon(Icons.call_rounded, size: 18, color: Colors.white),
                      label: const Text("Contact Now", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryIndigo,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Modern Grid Item Component
  Widget _infoCard(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B)),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  Widget _detailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryIndigo),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- ATTENDANCE LIST ---
  Widget _buildAttendanceList() {
    final filteredList = _drivers.where((d) {
      if (_selectedFilter == "All") return true;
      return d['status'] == _selectedFilter;
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final driver = filteredList[index];
        bool isAbsent = driver['status'] == "Absent";

        return GestureDetector(
          onTap: () => _showDriverDetails(driver), // ✅ Click karne par detail aayegi
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: isAbsent ? Colors.red.withOpacity(0.1) : primaryGreen.withOpacity(0.1),
                  child: Icon(isAbsent ? Icons.close_rounded : Icons.check_circle_rounded, color: isAbsent ? Colors.red : primaryGreen),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(driver['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text("ID: ${driver['id']} • ${driver['time']}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  // (Puraana _buildOverviewCard same rahega)
  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E293B), Color(0xFF334155)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Monthly Average", style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 4),
                  Text("94.5%", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                ],
              ),
              _buildProgressCircle(0.94, "94%"),
            ],
          ),
          const Divider(height: 30, color: Colors.white12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _miniStat("Present", "18", Colors.greenAccent),
              _miniStat("Leave", "02", Colors.orangeAccent),
              _miniStat("Absent", "01", Colors.redAccent),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProgressCircle(double val, String label) {
    return SizedBox(height: 60, width: 60, child: Stack(fit: StackFit.expand, children: [
      CircularProgressIndicator(value: val, strokeWidth: 6, backgroundColor: Colors.white10, color: Colors.greenAccent),
      Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
    ]));
  }

  Widget _miniStat(String label, String value, Color color) {
    return Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
    ]);
  }
}