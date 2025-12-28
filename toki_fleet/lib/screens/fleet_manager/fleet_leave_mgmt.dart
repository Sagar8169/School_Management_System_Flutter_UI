import 'package:flutter/material.dart';

class FleetLeaveMgmt extends StatefulWidget {
  const FleetLeaveMgmt({Key? key}) : super(key: key);

  @override
  State<FleetLeaveMgmt> createState() => _FleetLeaveMgmtState();
}

class _FleetLeaveMgmtState extends State<FleetLeaveMgmt> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dummy Data for Interaction
  final List<Map<String, dynamic>> _allRequests = [
    {"id": "LR-401", "name": "Ramesh Kumar", "drvId": "DRV-101", "dates": "25 Dec - 26 Dec", "reason": "Family Function", "status": "Pending"},
    {"id": "LR-402", "name": "Suresh Raina", "drvId": "DRV-105", "dates": "28 Dec - 30 Dec", "reason": "Medical Emergency", "status": "Pending"},
    {"id": "LR-403", "name": "Abdul Khan", "drvId": "DRV-112", "dates": "01 Jan - 02 Jan", "reason": "Personal Work", "status": "Pending"},
    {"id": "LR-404", "name": "Vicky Kaushal", "drvId": "DRV-109", "dates": "20 Dec - 21 Dec", "reason": "Sick Leave", "status": "Approved"},
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void _handleAction(int index, String status) {
    setState(() {
      _allRequests[index]['status'] = status;
    });

    // Show a modern SnackBar for feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Request ${status == 'Approved' ? 'Approved ✅' : 'Rejected ❌'}"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: status == 'Approved' ? Colors.green : Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFF97316); // Deep Orange

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Leave Management", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: "Pending Requests"),
            Tab(text: "Past History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaveList("Pending"),
          _buildLeaveList("Approved"),
        ],
      ),
    );
  }

  Widget _buildLeaveList(String filterStatus) {
    final list = _allRequests.where((r) => r['status'] == filterStatus).toList();

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_available_rounded, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text("No $filterStatus requests", style: const TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final request = list[index];
        final originalIndex = _allRequests.indexOf(request);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundColor: Colors.orange.withOpacity(0.1), child: const Icon(Icons.person, color: Colors.orange)),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(request['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(request['drvId'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        _statusChip(request['status']),
                      ],
                    ),
                    const Divider(height: 30),
                    _infoRow(Icons.calendar_month_rounded, "Dates", request['dates']),
                    const SizedBox(height: 8),
                    _infoRow(Icons.notes_rounded, "Reason", request['reason']),
                  ],
                ),
              ),
              if (filterStatus == "Pending")
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handleAction(originalIndex, "Rejected"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.redAccent),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Reject"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleAction(originalIndex, "Approved"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Approve", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusChip(String status) {
    Color color = status == "Pending" ? Colors.blue : (status == "Approved" ? Colors.green : Colors.red);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Text("$label: ", style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}