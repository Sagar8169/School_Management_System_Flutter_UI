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


  final Color _primaryBlue = const Color(0xFF2563EB); // Main Blue
  final Color _darkBlueCard = const Color(0xFF1E3A8A); // Inner Dark Blue
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  // Event Type Colors (Backgrounds and Text)
  final Map<String, Color> _typeColors = {
    'Meeting': const Color(0xFF3B82F6), // Blue
    'Sports': const Color(0xFF10B981), // Green
    'Exhibition': const Color(0xFF9333EA), // Purple
    'Holiday': const Color(0xFFF97316), // Orange
    'Celebration': const Color(0xFFEF4444), // Red
    'Exam': const Color(0xFFF59E0B), // Yellow/Amber
    'Event': const Color(0xFF64748B), // Slate/Grey
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

  final List<Map<String, dynamic>> _events = [
    {
      'type': 'Meeting',
      'title': 'Parent-Teacher Meeting',
      'subtitle': 'Discuss your child\'s progress with class teacher',
      'date': 'Nov 15, 2025',
      'time': '10:00 AM - 1:00 PM',
      'location': 'Class 8B Classroom',
    },
    {
      'type': 'Sports',
      'title': 'Annual Sports Day',
      'subtitle': 'Annual sports competition for all classes',
      'date': 'Nov 25, 2025',
      'time': '8:00 AM - 4:00 PM',
      'location': 'School Ground',
    },
    {
      'type': 'Exhibition',
      'title': 'Science Exhibition',
      'subtitle': 'Students showcase their science projects',
      'date': 'Dec 5, 2025',
      'time': '9:00 AM - 3:00 PM',
      'location': 'School Auditorium',
    },
    {
      'type': 'Holiday',
      'title': 'Winter Break',
      'subtitle': 'School closed for winter vacation',
      'date': 'Dec 15 - Dec 31, 2025',
      'time': 'All Day',
      'location': '-',
    },
    {
      'type': 'Celebration',
      'title': 'Republic Day Celebration',
      'subtitle': 'Flag hoisting and cultural programs',
      'date': 'Jan 26, 2026',
      'time': '9:00 AM - 12:00 PM',
      'location': 'School Ground',
    },
    {
      'type': 'Exam',
      'title': 'Final Exams',
      'subtitle': 'Annual final examinations',
      'date': 'Feb 10 - Feb 20, 2026',
      'time': '9:00 AM - 12:00 PM',
      'location': 'Exam Halls',
    },
    {
      'type': 'Event',
      'title': 'Annual Day Function',
      'subtitle': 'Annual cultural program and prize distribution',
      'date': 'Mar 15, 2026',
      'time': '5:00 PM - 8:00 PM',
      'location': 'School Auditorium',
    },
  ];

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _onBottomNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.home);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.busTracking);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.moreOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5722),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "A",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Aditya International School",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Powered by Toki Tech",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleLanguage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          color: Color(0xFFFF5722),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section (Blue)
                    _buildHeroSection(),

                    const SizedBox(height: 20),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "All Upcoming Events",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Event List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: _events.map((e) => _buildEventCard(e)).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),
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
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            label: "Bus",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "More",
          ),
        ],
      ),
    );
  }

  // --- Widgets ---

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _primaryBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button + Title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Upcoming Events",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Inner Dark Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _darkBlueCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Events This Academic Year",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "7",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Important dates to remember",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    final String type = event['type'];
    final Color color = _typeColors[type] ?? Colors.grey;
    final Color bgColor = _typeBgColors[type] ?? Colors.grey.shade100;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Icon + Type Badge + Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: _textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event['subtitle'],
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),

          // Details Rows
          _buildDetailRow(Icons.calendar_today_outlined, event['date']),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.access_time_outlined, event['time']),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.location_on_outlined, event['location']),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: _textSecondary,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}