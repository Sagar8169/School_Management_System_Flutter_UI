// lib/screens/parents/events_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedLanguage = 'తెలుగు';
  String _activeFilter = 'All';

  final Color _primaryBlue = const Color(0xFF2563EB);
  final Color _darkBlueCard = const Color(0xFF1E3A8A);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  final Map<String, Color> _typeColors = {
    'Meeting': const Color(0xFF3B82F6),
    'Sports': const Color(0xFF10B981),
    'Exhibition': const Color(0xFF9333EA),
    'Holiday': const Color(0xFFF97316),
    'Celebration': const Color(0xFFEF4444),
    'Exam': const Color(0xFFF59E0B),
    'Event': const Color(0xFF64748B),
  };

  final Map<String, Color> _typeBgColors = {
    'Meeting': const Color(0xFFEFF6FF),
    'Sports': const Color(0xFFECFDF5),
    'Exhibition': const Color(0xFFFAF5FF),
    'Holiday': const Color(0xFFFFF7ED),
    'Celebration': const Color(0xFFFEF2F2),
    'Exam': const Color(0xFFFFFBEB),
    'Event': const Color(0xFFF1F5F9),
  };

  final List<Map<String, dynamic>> _allEvents = [
    {'type': 'Meeting', 'title': 'Parent-Teacher Meeting', 'subtitle': 'Discuss progress with teacher', 'date': 'Nov 15, 2025', 'time': '10:00 AM - 1:00 PM', 'location': 'Room 8B'},
    {'type': 'Sports', 'title': 'Annual Sports Day', 'subtitle': 'Annual sports competition', 'date': 'Nov 25, 2025', 'time': '08:00 AM - 4:00 PM', 'location': 'School Ground'},
    {'type': 'Exhibition', 'title': 'Science Exhibition', 'subtitle': 'Science projects showcase', 'date': 'Dec 5, 2025', 'time': '09:00 AM - 3:00 PM', 'location': 'Auditorium'},
    {'type': 'Holiday', 'title': 'Winter Break', 'subtitle': 'School closed for vacation', 'date': 'Dec 15 - Dec 31, 2025', 'time': 'All Day', 'location': '-'},
  ];

  List<Map<String, dynamic>> get _filteredEvents {
    if (_activeFilter == 'All') return _allEvents;
    return _allEvents.where((e) => e['type'] == _activeFilter).toList();
  }

  void _showFilterSheet() {
    List<String> categories = ['All', ..._typeColors.keys];
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
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Text("Filter Events", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: categories.map((cat) {
                bool isSelected = _activeFilter == cat;
                return GestureDetector(
                  onTap: () {
                    setState(() => _activeFilter = cat);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryBlue : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
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
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Schedule: $_activeFilter", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: _textPrimary)),
                          GestureDetector(
                            onTap: _showFilterSheet,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: _primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.filter_list_rounded, color: _primaryBlue, size: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _filteredEvents.isEmpty
                          ? const Center(child: Padding(padding: EdgeInsets.only(top: 50), child: Text("No events found")))
                          : Column(children: _filteredEvents.map((e) => _buildEventCard(e)).toList()),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF5722),
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
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Aditya International", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B))),
              Text("Smart Event Portal", style: TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
          const Spacer(),
          const Text("తెలుగు", style: TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, colors: [_primaryBlue, const Color(0xFF1D4ED8)]),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(backgroundColor: Colors.white24, radius: 18, child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16)),
              ),
              const SizedBox(width: 12),
              const Text("Upcoming Events", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: _darkBlueCard, borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Active Academic Events", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${_allEvents.length}", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                      const Text("Events synchronized for you", style: TextStyle(color: Colors.white60, fontSize: 10)),
                    ],
                  ),
                ),
                Icon(Icons.event_note_rounded, color: Colors.white.withOpacity(0.2), size: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ YAHAN DETAILS ADD KI HAIN (TIME + LOCATION + SUBTITLE)
  Widget _buildEventCard(Map<String, dynamic> event) {
    final String type = event['type'];
    final Color themeColor = _typeColors[type] ?? Colors.grey;
    final Color themeBgColor = _typeBgColors[type] ?? Colors.grey.shade100;

    return Container(
      margin: const EdgeInsets.only(bottom: 18, left: 2, right: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // Soft modern shadow
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left Accent Bar (Indicator)
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Event Type Badge & Status/Icon (Optional)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: themeBgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Icon(Icons.event_note_outlined, size: 18, color: themeColor.withOpacity(0.5)),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Title
                      Text(
                        event['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: _textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Subtitle (Max 2 lines for cleanliness)
                      Text(
                        event['subtitle'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: _textSecondary.withOpacity(0.8),
                          height: 1.4,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(height: 1, color: Color(0xFFF1F5F9), thickness: 1),
                      ),

                      // Bottom Section: Info Grid
                      Wrap(
                        spacing: 20,
                        runSpacing: 12,
                        children: [
                          _infoLine(Icons.calendar_today_rounded, event['date'], themeColor),
                          _infoLine(Icons.access_time_filled_rounded, event['time'], themeColor),
                          if (event['location'] != '-')
                            _infoLine(Icons.location_on_rounded, event['location'], themeColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Optimized Info Row
  Widget _infoLine(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _textPrimary.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
  Widget _infoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
      ],
    );
  }
}