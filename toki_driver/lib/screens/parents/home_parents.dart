// lib/screens/parents/home_parents.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class HomeParents extends StatefulWidget {
  const HomeParents({Key? key}) : super(key: key);

  @override
  _HomeParentsState createState() => _HomeParentsState();
}

class _HomeParentsState extends State<HomeParents> {
  int _currentIndex = 0;
  String _selectedLanguage = 'తెలుగు';
  bool _showAlert = true;

  // Color Palette extracted from images
  final Color _primaryOrange = const Color(0xFFFF5722);
  final Color _heroStatBg = const Color(0xFFF44336);
  final Color _scaffoldBg = const Color(0xFFF5F5F5);
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  // Navigation methods
  void _navigateToAttendance() => Navigator.pushNamed(context, ParentsRoutes.attendance);
  void _navigateToGrades() => Navigator.pushNamed(context, ParentsRoutes.grades);
  void _navigateToHomework() => Navigator.pushNamed(context, ParentsRoutes.homework);
  void _navigateToAnnouncements() => Navigator.pushNamed(context, ParentsRoutes.announcements);
  void _navigateToEvents() => Navigator.pushNamed(context, ParentsRoutes.events);
  void _navigateToBusTracking() => Navigator.pushNamed(context, ParentsRoutes.busTracking);
  void _navigateToTickets() => Navigator.pushNamed(context, ParentsRoutes.tickets);
  void _navigateToMoreOptions() => Navigator.pushNamed(context, ParentsRoutes.moreOptions);
  void _navigateToTodayFullDetails() => Navigator.pushNamed(context, ParentsRoutes.todayFullDetails);

  void _onBottomNavTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        break; // Already on Home
      case 1:
        Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, ParentsRoutes.busTracking);
        break;
      case 3:
        _navigateToMoreOptions();
        break;
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
                      color: _primaryOrange,
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
                        style: TextStyle(
                          color: _primaryOrange,
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section
                    _buildHeroSection(),
                    const SizedBox(height: 16),

                    // Alert Banner
                    if (_showAlert) ...[
                      _buildAlertBanner(),
                      const SizedBox(height: 16),
                    ],

                    // NEW TODAY'S SUMMARY BLUE TILE
                    _buildTodaySummaryTile(),
                    const SizedBox(height: 12),

                    // ATTENDANCE ANALYTICS TILE
                    _buildGenericCard(
                      onTap: _navigateToAttendance,
                      icon: Icons.analytics_outlined,
                      iconColor: const Color(0xFF10B981),
                      iconBg: const Color(0xFFD1FAE5),
                      title: "Attendance Analytics",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "This Month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "November 2025",
                                    style: TextStyle(
                                      color: _textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD1FAE5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "95.5%",
                                  style: TextStyle(
                                    color: const Color(0xFF059669),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildAttendanceStat("21", "Present", Colors.green),
                              _buildAttendanceStat("1", "Absent", Colors.red),
                              _buildAttendanceStat("22", "Total", Colors.blue),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Icon(Icons.trending_up, size: 16, color: Colors.green),
                              const SizedBox(width: 6),
                              Text(
                                "Trend: +2% from last month",
                                style: TextStyle(color: _textSecondary, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          GestureDetector(
                            onTap: _navigateToAttendance,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "View detailed analytics ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Grades Card
                    _buildGenericCard(
                      onTap: _navigateToGrades,
                      icon: Icons.star_border,
                      iconColor: const Color(0xFFF59E0B),
                      iconBg: const Color(0xFFFEF3C7),
                      title: "Latest Grades",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mid-term Exam",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "October 2025",
                                    style: TextStyle(color: _textSecondary, fontSize: 12),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD1FAE5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "A+ Grade",
                                  style: TextStyle(
                                    color: Color(0xFF059669),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Overall Score: 92%",
                            style: TextStyle(color: _textSecondary, fontSize: 13),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildGradeStat("Rank", "3rd"),
                              _buildGradeStat("Subjects", "8"),
                              _buildGradeStat("Avg Score", "92%"),
                            ],
                          ),
                          const SizedBox(height: 12),

                          GestureDetector(
                            onTap: _navigateToGrades,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "View report card ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Bus Tracking Card
                    _buildGenericCard(
                      onTap: _navigateToBusTracking,
                      icon: Icons.directions_bus_filled_outlined,
                      iconColor: const Color(0xFFF59E0B),
                      iconBg: const Color(0xFFFFF7ED),
                      title: "Bus Tracking",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Bus Route 5 • KA-01-AB-1234",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Currently at: Sector 12 • ETA: 15 mins",
                            style: TextStyle(color: _textSecondary, fontSize: 12),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildBusSchedule("Morning", "7:30 AM", "On Time"),
                              _buildBusSchedule("Evening", "3:45 PM", "Scheduled"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: _navigateToBusTracking,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "View live tracking ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Upcoming Events
                    _buildGenericCard(
                      onTap: _navigateToEvents,
                      icon: Icons.calendar_today,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFEFF6FF),
                      title: "Upcoming Events",
                      child: Column(
                        children: [
                          _buildEventRow("Parent-Teacher Meeting", "Nov 15"),
                          const SizedBox(height: 10),
                          _buildEventRow("Annual Sports Day", "Nov 25"),
                          const SizedBox(height: 10),
                          _buildEventRow("Science Exhibition", "Dec 5"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Recent Updates
                    _buildGenericCard(
                      onTap: _navigateToAnnouncements,
                      icon: Icons.info_outline,
                      iconColor: const Color(0xFFDC2626),
                      iconBg: const Color(0xFFFEE2E2),
                      title: "Recent Updates",
                      child: Column(
                        children: [
                          _buildUpdateItem(
                            isNew: true,
                            time: "2 hours ago",
                            text:
                            "School will remain closed on Nov 11 due to public holiday",
                          ),
                          const SizedBox(height: 12),
                          _buildUpdateItem(
                            isNew: false,
                            time: "Yesterday",
                            text:
                            "Mid-term exam results published. Check Grades section.",
                          ),
                          const SizedBox(height: 12),
                          _buildUpdateItem(
                            isNew: false,
                            time: "2 days ago",
                            text: "Parent-Teacher meeting scheduled for Nov 15",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tickets Card
                    _buildGenericCard(
                      onTap: _navigateToTickets,
                      icon: Icons.chat_bubble_outline,
                      iconColor: const Color(0xFF10B981),
                      iconBg: const Color(0xFFD1FAE5),
                      title: "Support Tickets",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTicketStat("Active", "1", Colors.orange),
                              _buildTicketStat("Resolved", "3", Colors.green),
                              _buildTicketStat("Total", "4", Colors.blue),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: _navigateToTickets,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "View all tickets ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
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
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _primaryOrange,
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

  // --- NEW TODAY'S SUMMARY TILE ---
  Widget _buildTodaySummaryTile() {
    return GestureDetector(
      onTap: _navigateToTodayFullDetails,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2563EB).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Summary",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.access_time_outlined,
                  color: Colors.white.withOpacity(0.9),
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List Items
            Column(
              children: [
                _buildSummaryRow(
                  icon: Icons.check_circle_outline,
                  iconBg: const Color(0xFF10B981),
                  title: "Attendance",
                  subtitle: "Marked Present",
                  rightWidget: Text(
                    "9:15 AM",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSummaryRow(
                  icon: Icons.directions_bus,
                  iconBg: const Color(0xFFF59E0B),
                  title: "Morning Bus",
                  subtitle: "Reached School",
                  rightWidget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                    ),
                    child: Text(
                      "On Time",
                      style: const TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSummaryRow(
                  icon: Icons.menu_book_outlined,
                  iconBg: const Color(0xFF8B5CF6),
                  title: "Today's Schedule",
                  subtitle: "6 Classes • 1 Lab",
                  rightWidget: Icon(
                    Icons.chevron_right,
                    color: Colors.white.withOpacity(0.7),
                    size: 20,
                  ),
                ),
                const SizedBox(height: 10),
                _buildSummaryRow(
                  icon: Icons.assignment_outlined,
                  iconBg: const Color(0xFFEC4899),
                  title: "Homework",
                  subtitle: "1 Assignment Due",
                  rightWidget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.3)),
                    ),
                    child: Text(
                      "Today",
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSummaryRow(
                  icon: Icons.event_outlined,
                  iconBg: const Color(0xFFF97316),
                  title: "Today's Event",
                  subtitle: "Sports Day Practice",
                  rightWidget: Text(
                    "3:30 PM",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSummaryRow(
                  icon: Icons.directions_bus,
                  iconBg: const Color(0xFFF97316),
                  title: "Evening Bus",
                  subtitle: "Departs at 4:00 PM",
                  rightWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.9),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "2h 15m",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Footer Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: _navigateToTodayFullDetails,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Full Details ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget rightWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          rightWidget,
        ],
      ),
    );
  }

  // --- Hero Section ---
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _primaryOrange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Ananya Sharma",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Class 8B • Roll No. 12",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeroStatPill("95%", "Attendance"),
                const SizedBox(width: 10),
                _buildHeroStatPill("A+", "Grade"),
                const SizedBox(width: 10),
                _buildHeroStatPill("3", "Homework"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: const Border(top: BorderSide(color: Colors.white24)),
            ),
            child: Row(
              children: const [
                Icon(Icons.calendar_today_outlined, color: Colors.white70, size: 14),
                SizedBox(width: 8),
                Text(
                  "Saturday, November 9, 2025",
                  style: TextStyle(
                    color: Colors.white,
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

  Widget _buildHeroStatPill(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _heroStatBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Alert Banner ---
  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Cyclone Alert - School Closed",
                    style: TextStyle(
                      color: Color(0xFF7F1D1D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _showAlert = false),
                child: const Icon(Icons.close, size: 18, color: Color(0xFF7F1D1D)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Due to severe cyclone warning, school will remain closed on October 21-22, 2025. Stay safe!",
            style: TextStyle(
              color: Color(0xFF7F1D1D),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // --- Generic Card Builder ---
  Widget _buildGenericCard({
    required VoidCallback onTap,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: _textPrimary,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  // Event row widget
  Widget _buildEventRow(String title, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: _textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            color: _textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // Update item widget
  Widget _buildUpdateItem({required bool isNew, required String time, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isNew)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "New",
                  style: TextStyle(
                    color: Color(0xFFE11D48),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              time,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            color: _textPrimary,
            fontSize: 13,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  // Attendance stat widget
  Widget _buildAttendanceStat(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: _textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // Grade stat widget
  Widget _buildGradeStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: _textSecondary,
          ),
        ),
      ],
    );
  }

  // Bus schedule widget
  Widget _buildBusSchedule(String session, String time, String status) {
    Color statusColor = status == "On Time" ? Colors.green : Colors.orange;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              session,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 11,
            color: _textSecondary,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Ticket stat widget
  Widget _buildTicketStat(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: _textSecondary,
          ),
        ),
      ],
    );
  }
}

// Period Chip widget for Today's Classes (moved outside the class)
class PeriodChip extends StatelessWidget {
  final String period;
  final String subject;

  const PeriodChip({
    Key? key,
    required this.period,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "$period. $subject",
        style: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
        ),
      ),
    );
  }
}