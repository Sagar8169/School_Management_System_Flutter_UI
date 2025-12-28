import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 3;
  bool _isTelugu = true;
  late TabController _tabController;
  // --- DUMMY DATA WITH WORKING STATE ---
  final List<Map<String, dynamic>> _events = [
    {'id': 1, 'title': 'Annual Sports Meet', 'date': '28 Dec', 'month': 'DEC', 'time': '09:00 AM', 'venue': 'Main Ground', 'status': 'Upcoming', 'category': 'Sports'},
    {'id': 2, 'title': 'Science Exhibition', 'date': '30 Dec', 'month': 'DEC', 'time': '10:30 AM', 'venue': 'Science Lab', 'status': 'Upcoming', 'category': 'Academic'},
    {'id': 3, 'title': 'Christmas Celebration', 'date': '25 Dec', 'month': 'DEC', 'time': '11:00 AM', 'venue': 'Hall', 'status': 'Past', 'category': 'Cultural'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // --- WORKING: DELETE EVENT ---
  void _deleteEvent(int id) {
    setState(() {
      _events.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Event removed successfully"), behavior: SnackBarBehavior.floating),
    );
  }

  // --- WORKING: ADD EVENT DIALOG ---
  void _showAddEventSheet() {
    TextEditingController titleCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 24, left: 24, right: 24, top: 12),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 24),
            const Text("Schedule New Event", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
            const SizedBox(height: 20),
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                hintText: "Event Title (e.g. Republic Day)",
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (titleCtrl.text.isNotEmpty) {
                    setState(() {
                      _events.insert(0, {
                        'id': DateTime.now().millisecond,
                        'title': titleCtrl.text,
                        'date': '01 Jan',
                        'month': 'JAN',
                        'time': '10:00 AM',
                        'venue': 'School Premises',
                        'status': 'Upcoming',
                        'category': 'General'
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text("SAVE EVENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // 🔝 PREMIUM HEADER
          _buildPremiumHeader(),

          // 🔽 TAB CONTENT
          Expanded(
            child: Column(
              children: [
                // 🔹 TAB BAR
                TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF1D4ED8),
                  unselectedLabelColor: const Color(0xFF94A3B8),
                  indicatorColor: const Color(0xFF1D4ED8),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800),
                  tabs: const [
                    Tab(text: "Upcoming"),
                    Tab(text: "Past"),
                  ],
                ),

                // 🔹 TAB VIEWS
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildEventList('Upcoming'),
                      _buildEventList('Past'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ➕ FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEventSheet,
        backgroundColor: const Color(0xFF0F172A),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          "POST EVENT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ),

      // 🔻 BOTTOM NAV
      bottomNavigationBar: _buildCleanBottomNav(),
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
                  'Upcoming Events',
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

  Widget _buildEventList(String status) {
    final filtered = _events.where((e) => e['status'] == status).toList();
    if (filtered.isEmpty) return _buildEmptyState();

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _buildPremiumEventCard(filtered[index]),
    );
  }

  Widget _buildPremiumEventCard(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Column(
                children: [
                  Text(event['date'].split(' ')[0], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF059669))),
                  Text(event['month'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _categoryTag(event['category']),
                      GestureDetector(
                        onTap: () => _deleteEvent(event['id']),
                        child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(event['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _iconDetail(Icons.access_time_rounded, event['time']),
                      const SizedBox(width: 15),
                      _iconDetail(Icons.location_on_outlined, event['venue']),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryTag(String label) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(8)), child: Text(label, style: const TextStyle(color: Color(0xFF059669), fontSize: 9, fontWeight: FontWeight.w900)));

  Widget _iconDetail(IconData icon, String text) => Row(children: [Icon(icon, size: 14, color: const Color(0xFF94A3B8)), const SizedBox(width: 5), Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600))]);

  Widget _buildEmptyState() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.event_busy_rounded, size: 60, color: Colors.grey[200]), const SizedBox(height: 16), const Text("No events found", style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600))]));
}