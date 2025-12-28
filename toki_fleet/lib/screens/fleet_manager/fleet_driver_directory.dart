import 'package:flutter/material.dart';

class FleetDriverDirectory extends StatefulWidget {
  const FleetDriverDirectory({Key? key}) : super(key: key);

  @override
  State<FleetDriverDirectory> createState() => _FleetDriverDirectoryState();
}

class _FleetDriverDirectoryState extends State<FleetDriverDirectory> {
  static const primaryTeal = Color(0xFF0D9488);

  // Dummy Data with extra details for the detail view
  final List<Map<String, dynamic>> _allDrivers = List.generate(10, (index) => {
    "id": "AIS-DRV-10${index + 1}",
    "name": "Driver Name ${index + 1}",
    "phone": "+91 98765 4321${index}",
    "route": "Route 0${index + 1}",
    "status": index % 3 == 0 ? "Online" : "Offline",
    "license": "TS-09-2023-000${index + 5}",
    "blood": index % 2 == 0 ? "O+" : "B+",
    "exp": "${(index + 2)} Years",
  });

  List<Map<String, dynamic>> _foundDrivers = [];

  @override
  void initState() {
    _foundDrivers = _allDrivers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allDrivers;
    } else {
      results = _allDrivers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundDrivers = results;
    });
  }

  // --- DRIVER DETAIL BOTTOM SHEET ---
  void _showDriverDetails(Map<String, dynamic> driver) {
    bool isOnline = driver["status"] == "Online";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Takki keyboard ya lambe content pe issue na ho
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),

              // Header Section with Status Badge
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: primaryTeal.withOpacity(0.1),
                    child: const Icon(Icons.person, size: 40, color: primaryTeal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver["name"],
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isOnline ? "ON DUTY" : "OFF DUTY",
                            style: TextStyle(
                              color: isOnline ? Colors.green : Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Divider(height: 1),
              const SizedBox(height: 24),

              // Info Grid (2x2 Layout)
              Row(
                children: [
                  _infoBlock(Icons.badge_rounded, "License", driver["license"]),
                  _infoBlock(Icons.phone_android_rounded, "Contact", driver["phone"]),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _infoBlock(Icons.history_toggle_off_rounded, "Experience", driver["exp"]),
                  _infoBlock(Icons.local_hospital_rounded, "Blood Type", driver["blood"]),
                ],
              ),

              const SizedBox(height: 35),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: _bottomActionBtn(
                        Icons.chat_bubble_rounded,
                        "Message",
                        Colors.blue,
                            () {}
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _bottomActionBtn(
                        Icons.call_rounded,
                        "Call Driver",
                        Colors.green,
                            () {}
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

  // Modern Info Grid Block
  Widget _infoBlock(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: primaryTeal),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF334155))),
            ],
          ),
        ],
      ),
    );
  }

  // Action Button Builder
  Widget _bottomActionBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryTeal),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Driver Directory", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 18), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          Expanded(
            child: _foundDrivers.isNotEmpty
                ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _foundDrivers.length,
              itemBuilder: (context, index) => _buildDriverCard(_foundDrivers[index]),
            )
                : const Center(child: Text("No drivers found")),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      color: Colors.white,
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          hintText: "Search by name...",
          prefixIcon: const Icon(Icons.search, color: primaryTeal, size: 20),
          filled: true,
          fillColor: const Color(0xFFF1F5F9),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    bool isOnline = driver["status"] == "Online";

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showDriverDetails(driver),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildProfileImage(isOnline),
            const SizedBox(width: 14),

            /// NAME + META
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${driver['route']} • ${driver['id']}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            /// STATUS CHIP
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isOnline
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isOnline ? "ONLINE" : "OFFLINE",
                style: TextStyle(
                  color: isOnline ? Colors.green : Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(bool isOnline) {
    return Stack(
      children: [
        CircleAvatar(radius: 28, backgroundColor: primaryTeal.withOpacity(0.1), child: const Icon(Icons.person_rounded, color: primaryTeal)),
        Positioned(
          right: 2, bottom: 2,
          child: Container(
            height: 12, width: 12,
            decoration: BoxDecoration(color: isOnline ? Colors.green : Colors.grey, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _circleIconButton(Icons.message_rounded, Colors.blue),
        const SizedBox(width: 8),
        _circleIconButton(Icons.call, Colors.green),
      ],
    );
  }

  Widget _circleIconButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: color, size: 20),
    );
  }
}