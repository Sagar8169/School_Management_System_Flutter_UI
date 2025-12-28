import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  // ✅ STATE VARIABLES
  String _selectedLanguage = 'తెలుగు';
  String _activeFilter = 'All';

  // ✅ COLOUR PALETTE
  final Color _heroRed = const Color(0xFFD34031);
  final Color _heroCardBg = const Color(0xFFB02E23);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  // ✅ FULL ANNOUNCEMENT DATA (7 ITEMS)
  final List<Map<String, dynamic>> _allAnnouncements = [
    {
      'type': 'Important',
      'isNew': true,
      'time': "2 hours ago",
      'title': "School Holiday on November 11",
      'message': "School will remain closed on Nov 11, 2025 due to public holiday. Classes resume from Nov 12.",
      'iconBg': const Color(0xFFFFEBEE),
      'iconColor': const Color(0xFFEF5350),
    },
    {
      'type': 'Important',
      'isNew': true,
      'time': "Yesterday",
      'title': "Mid-term Results Published",
      'message': "Mid-term examination results have been published. Please check the Grades section to view performance.",
      'iconBg': const Color(0xFFFFEBEE),
      'iconColor': const Color(0xFFEF5350),
    },
    {
      'type': 'Notice',
      'isNew': false,
      'time': "2 days ago",
      'title': "Parent-Teacher Meeting on Nov 15",
      'message': "PTM is scheduled for Nov 15, 2025 from 10:00 AM to 1:00 PM. Please make sure to attend.",
      'iconBg': const Color(0xFFFFF8E1),
      'iconColor': const Color(0xFFFBC02D),
    },
    {
      'type': 'Notice',
      'isNew': false,
      'time': "3 days ago",
      'title': "Winter Uniform Notice",
      'message': "Students must wear winter uniform starting from Nov 15, 2025. Summer uniform is not allowed.",
      'iconBg': const Color(0xFFFFF8E1),
      'iconColor': const Color(0xFFFBC02D),
    },
    {
      'type': 'Reminder',
      'isNew': false,
      'time': "4 days ago",
      'title': "Library Book Return Reminder",
      'message': "All library books must be returned by Nov 20, 2025. Late fees applicable after due date.",
      'iconBg': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF4285F4),
    },
    {
      'type': 'Notice',
      'isNew': false,
      'time': "5 days ago",
      'title': "Annual Sports Day Registration",
      'message': "Registration for Sports Day 2025 is now open. Contact sports department to register your child.",
      'iconBg': const Color(0xFFFFF8E1),
      'iconColor': const Color(0xFFFBC02D),
    },
    {
      'type': 'Reminder',
      'isNew': false,
      'time': "1 week ago",
      'title': "Flu Vaccination Camp",
      'message': "A vaccination camp will be organized on Nov 18. Parents can opt-in through school office.",
      'iconBg': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF4285F4),
    },
  ];

  // ✅ FILTER LOGIC
  List<Map<String, dynamic>> get _filteredList {
    if (_activeFilter == 'All') return _allAnnouncements;
    return _allAnnouncements.where((item) => item['type'] == _activeFilter).toList();
  }

  // ✅ FILTER SHEET (Appears over the content)
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            const Text("Filter Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: ['All', 'Important', 'Notice', 'Reminder'].map((cat) {
                bool isSelected = _activeFilter == cat;
                return GestureDetector(
                  onTap: () {
                    setState(() => _activeFilter = cat);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(color: isSelected ? _heroRed : Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                    child: Text(cat, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, ParentsRoutes.home);
    else if (index == 1) Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
    else if (index == 2) Navigator.pushReplacementNamed(context, ParentsRoutes.busTracking);
    else if (index == 3) Navigator.pushReplacementNamed(context, ParentsRoutes.moreOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Schedule: $_activeFilter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: _textPrimary, letterSpacing: -0.5)),
                          GestureDetector(
                            onTap: _showFilterSheet,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: _heroRed.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.filter_list_rounded, color: _heroRed, size: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._filteredList.map((item) => _buildAnnouncementCard(item)).toList(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, onTap: _onBottomNavTap, type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF5722), unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: "Bus"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "More"),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(8)), alignment: Alignment.center, child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
          const SizedBox(width: 12),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Aditya International School", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text("Powered by Toki Tech", style: TextStyle(color: Colors.grey, fontSize: 11))]),
          const Spacer(),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(20), color: Colors.white), child: Text(_selectedLanguage, style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w600, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, colors: [_heroRed, const Color(0xFFE53935)]), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)), boxShadow: [BoxShadow(color: _heroRed.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16))), const SizedBox(width: 12), const Text("Recent Updates", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 24),
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: _heroCardBg, borderRadius: BorderRadius.circular(24)), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Broadcast System", style: TextStyle(color: Colors.white70, fontSize: 13)), const SizedBox(height: 4), Text("${_filteredList.length}", style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)), const Text("Updates based on filter", style: TextStyle(color: Colors.white60, fontSize: 11))])), Icon(Icons.campaign_rounded, color: Colors.white.withOpacity(0.2), size: 50)])),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(children: [
            Container(width: 5, color: item['iconColor']),
            Expanded(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: item['iconBg'], borderRadius: BorderRadius.circular(10)), child: Icon(Icons.info_rounded, color: item['iconColor'], size: 18)), const SizedBox(width: 10), if (item['isNew']) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(6)), child: const Text("NEW", style: TextStyle(color: Color(0xFFE53935), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)))]), Text(item['time'], style: TextStyle(color: _textSecondary, fontSize: 11, fontWeight: FontWeight.w600))]),
              const SizedBox(height: 14),
              Text(item['title'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: _textPrimary)),
              const SizedBox(height: 8),
              Text(item['message'], style: TextStyle(fontSize: 13, color: _textSecondary, height: 1.5, fontWeight: FontWeight.w500)),
              const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1, color: Color(0xFFF1F5F9))),
              Row(children: [Text("Posted by: Admin Office", style: TextStyle(fontSize: 11, color: _textSecondary, fontWeight: FontWeight.bold)), const Spacer(), const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey)]),
            ]))),
          ]),
        ),
      ),
    );
  }
}