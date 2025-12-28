import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';
const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);
class ApprovalsPage extends StatefulWidget {
  const ApprovalsPage({super.key});

  @override
  State<ApprovalsPage> createState() => _ApprovalsPageState();
}

class _ApprovalsPageState extends State<ApprovalsPage> {

  int _currentIndex = 3;

  bool _isTelugu = true;

  // Dummy Data with Working Logic
  final List<Map<String, dynamic>> _pendingRequests = [
    {'id': 1, 'name': 'Mrs. Ragini Sharma', 'type': 'Leave Request', 'reason': 'Medical Emergency', 'date': '26 Dec 2025', 'icon': Icons.medical_services_rounded},
    {'id': 2, 'name': 'Mr. Amit Verma', 'type': 'Expense Claim', 'reason': 'Lab Equipment', 'date': '27 Dec 2025', 'icon': Icons.payments_rounded},
    {'id': 3, 'name': 'Ms. Priya Das', 'type': 'Leave Request', 'reason': 'Family Function', 'date': '28 Dec 2025', 'icon': Icons.home_rounded},
    {'id': 4, 'name': 'Mr. Suresh Raina', 'type': 'Inventory', 'reason': 'Sports Gear Purchase', 'date': '29 Dec 2025', 'icon': Icons.sports_cricket_rounded},
  ];

  void _processRequest(int id, String action, String name) {
    setState(() {
      _pendingRequests.removeWhere((item) => item['id'] == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(action == 'approve' ? "Request Approved for $name" : "Request Rejected for $name"),
        backgroundColor: action == 'approve' ? const Color(0xFF10B981) : const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isTelugu ? "తెలుగు భాషలోకి మార్చబడింది" : "Switched to English"),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildPremiumHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 10,
        20,
        10,
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
                color: Color(0xFF1E293B),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 🏫 Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pending Approvals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'School Statistics Insights',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language Toggle
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: Column(
        children: [
          _buildPremiumHeader(), // ✅ yahan sahi hai

          Expanded(
            child: _pendingRequests.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: _pendingRequests.length,
              itemBuilder: (context, index) {
                final request = _pendingRequests[index];
                return _buildApprovalCard(request);
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: _buildBottomNav(),
    );
  }


    void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

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

  Widget _buildCleanBottomNav() {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color(0xFF1D4ED8),
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 24), activeIcon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded, size: 24), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded, size: 24), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded, size: 24), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildApprovalCard(Map<String, dynamic> request) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(14)),
                  child: Icon(request['icon'], color: const Color(0xFF1D4ED8), size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request['type'].toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1)),
                      const SizedBox(height: 2),
                      Text(request['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                    ],
                  ),
                ),
                Text(request['date'], style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, color: Color(0xFFF1F5F9)),
            ),
            Row(
              children: [
                const Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Reason: ${request['reason']}",
                    style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _actionBtn("Reject", const Color(0xFFEF4444), () => _processRequest(request['id'], 'reject', request['name'])),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionBtn("Approve", const Color(0xFF10B981), () => _processRequest(request['id'], 'approve', request['name']), isPrimary: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFF1F5F9),
            width: 2,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,

        // ✅ CORRECT onTap (int only)
        onTap: (index) {
          if (index == _currentIndex) return;
          _onBottomNavTap(index);
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: themeBlue,
        unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "More",
          ),
        ],
      ),
    );
  }
  Widget _actionBtn(String label, Color color, VoidCallback onTap, {bool isPrimary = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? color : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary ? null : Border.all(color: color.withOpacity(0.5)),
          boxShadow: isPrimary ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: isPrimary ? Colors.white : color, fontWeight: FontWeight.w900, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_rounded, size: 80, color: Colors.grey[200]),
          const SizedBox(height: 16),
          const Text("All Caught Up!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          const Text("No pending approvals at the moment.", style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}