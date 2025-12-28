import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> with SingleTickerProviderStateMixin {

  bool _isTelugu = true;


  int _currentIndex = 3;

  late TabController _tabController;

  // Principal ke liye sample tickets (Raised by Teachers/Students)
  final List<Map<String, dynamic>> _allTickets = [
    {'id': '#TK-901', 'raisedBy': 'Teacher: Anita Rao', 'title': 'Projector not working in 10-A', 'status': 'Open', 'priority': 'High', 'time': '30m ago', 'category': 'Infrastructure'},
    {'id': '#TK-895', 'raisedBy': 'Student: Rahul (9B)', 'title': 'Locker key lost', 'status': 'Open', 'priority': 'Low', 'time': '1h ago', 'category': 'Admin'},
    {'id': '#TK-880', 'raisedBy': 'Teacher: Vikram', 'title': 'Syllabus update error in app', 'status': 'Resolved', 'priority': 'Medium', 'time': '1d ago', 'category': 'Technical'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _updateTicketStatus(String ticketId, String newStatus) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Ticket $ticketId marked as $newStatus"),
        backgroundColor: newStatus == 'Resolved' ? Colors.green : Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // 🔝 PREMIUM HEADER
          _buildPremiumHeader(),

          // 🔽 PAGE CONTENT
          Expanded(
            child: Column(
              children: [
                _buildQuickStats(),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildAdminTicketList('Open'),
                      _buildAdminTicketList('Resolved'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 🔻 BOTTOM NAV (Scaffold level ONLY)
      bottomNavigationBar: _buildCleanBottomNav(),
    );
  }


  PreferredSizeWidget _buildPrincipalAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(140),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).padding.top + 10,
          20,
          0,
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
              offset: const Offset(0, 6), // 👈 bottom-only shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔝 Top Row (Back + Title)
            Row(
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

                // 🏷️ Title + Subtitle
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Grievance Desk",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Manage Faculty & Student issues",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 📑 Tab Bar
            TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF1D4ED8),
              unselectedLabelColor: const Color(0xFF94A3B8),
              indicatorColor: const Color(0xFF1D4ED8),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(fontWeight: FontWeight.w800),
              tabs: const [
                Tab(text: "New Issues"),
                Tab(text: "Solved"),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
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
                  'Tickets',
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

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem("12", "Pending", Colors.orange),
          _statItem("45", "Resolved", Colors.green),
          _statItem("03", "Urgent", Colors.red),
        ],
      ),
    );
  }

  Widget _statItem(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Text(count, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 14)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color.withOpacity(0.8), fontWeight: FontWeight.w700, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildAdminTicketList(String status) {
    final tickets = _allTickets.where((t) => t['status'] == status).toList();
    if (tickets.isEmpty) return const Center(child: Text("No issues found"));

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tickets.length,
      itemBuilder: (context, index) => _buildAdminTicketCard(tickets[index]),
    );
  }

  Widget _buildAdminTicketCard(Map<String, dynamic> ticket) {
    bool isOpen = ticket['status'] == 'Open';
    Color pColor = ticket['priority'] == 'High' ? Colors.red : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ticket['id'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: Color(0xFF94A3B8))),
                    _tag(ticket['priority'], pColor),
                  ],
                ),
                const SizedBox(height: 12),
                Text(ticket['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                const SizedBox(height: 6),
                Text("Raised by: ${ticket['raisedBy']}", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _miniInfo(Icons.category_outlined, ticket['category']),
                    const Spacer(),
                    _miniInfo(Icons.access_time_rounded, ticket['time']),
                  ],
                ),
              ],
            ),
          ),
          if (isOpen) ...[
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: _adminActionBtn("In Progress", Colors.blue, () => _updateTicketStatus(ticket['id'], 'In Progress')),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _adminActionBtn("Solve Ticket", Colors.green, () => _updateTicketStatus(ticket['id'], 'Resolved'), isPrimary: true),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _adminActionBtn(String label, Color color, VoidCallback onTap, {bool isPrimary = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? color : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: color.withOpacity(0.5)),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: isPrimary ? Colors.white : color, fontWeight: FontWeight.w800, fontSize: 12)),
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String text) => Row(children: [Icon(icon, size: 14, color: const Color(0xFFCBD5E1)), const SizedBox(width: 5), Text(text, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600))]);

  Widget _tag(String text, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8)), child: Text(text, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)));
}