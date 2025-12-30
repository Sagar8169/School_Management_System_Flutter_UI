import 'package:flutter/material.dart';
import 'package:toki/routes/parents_routes.dart';
import 'package:toki/screens/parents/attendance_record_page.dart';
import 'package:toki/screens/parents/bus_tracking_page.dart';
import 'package:toki/screens/parents/class_timetable_page.dart';
import 'package:toki/screens/parents/events_page.dart';
import 'package:toki/screens/parents/homework_page.dart';

class ParentsHomePage extends StatefulWidget {
  const ParentsHomePage({super.key});

  @override
  State<ParentsHomePage> createState() => _ParentsHomePageState();
}

class _ParentsHomePageState extends State<ParentsHomePage> {
  String _selectedLanguage = 'తెలుగు';

  bool _showAlert = true;

  // Color Palette extracted from images
  final Color _primaryOrange = const Color(0xFFFF5722);
  final Color _headerOrange = const Color(0xFFFF5722); // Deep Orange

  final Color _heroStatBg = const Color(0xFFF44336);

  final Color _scaffoldBg = const Color(0xFFF5F5F5);

  final Color _textPrimary = const Color(0xFF1F2937);

  final Color _textSecondary = const Color(0xFF6B7280);
  String activeFilter = "All";
  final List<String> categories = ["All", "Unread", "Exams", "Bus", "Homework"];

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _navigateToAttendance() =>
      Navigator.pushNamed(context, ParentsRoutes.attendance);
  void _navigateToGrades() =>
      Navigator.pushNamed(context, ParentsRoutes.grades);
  void _navigateToHomework() =>
      Navigator.pushNamed(context, ParentsRoutes.homework);
  void _navigateToAnnouncements() =>
      Navigator.pushNamed(context, ParentsRoutes.announcements);
  void _navigateToEvents() =>
      Navigator.pushNamed(context, ParentsRoutes.events);
  void _navigateToBusTracking() =>
      Navigator.pushNamed(context, ParentsRoutes.busTracking);
  void _navigateToTickets() =>
      Navigator.pushNamed(context, ParentsRoutes.tickets);
  void _navigateToMoreOptions() =>
      Navigator.pushNamed(context, ParentsRoutes.moreOptions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Modern light background
      body: SafeArea(
        child: Column(
          children: [
            /// 1. App Header (Clean & Branded)
            _buildAppHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    /// 2. Hero Section (Student Profile)
                    _buildHeroSection(),

                    const SizedBox(height: 20),

                    /// 3. Alert Banner (Important Notifications)
                    if (_showAlert) ...[
                      _buildAlertBanner(),
                      const SizedBox(height: 20),
                    ],

                    /// 4. Today's Summary (The High-Impact Blue Tile)
                    _buildTodaySummaryTile(),

                    const SizedBox(height: 24),

                    _buildSectionHeading("Performance & Tracking"),
                    const SizedBox(height: 12),

                    /// 5. Attendance Analytics (Modern Data Viz)
                    _buildAttendanceCard(),

                    const SizedBox(height: 12),

                    /// 6. Latest Grades (Metric Cards)
                    _buildGradesCard(),

                    const SizedBox(height: 24),
                    _buildSectionHeading("Daily Utilities"),
                    const SizedBox(height: 12),

                    /// 7. Homework & Bus tracking
                    _buildHomeworkCard(),
                    const SizedBox(height: 12),
                    _buildBusTrackingCard(),

                    const SizedBox(height: 24),
                    _buildSectionHeading("School Updates"),
                    const SizedBox(height: 12),

                    /// 8. Events & Support
                    _buildEventsCard(),
                    const SizedBox(height: 12),
                    _buildSupportTicketsCard(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [_primaryOrange, _primaryOrange.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: _primaryOrange.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            alignment: Alignment.center,
            child: const Text("A",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Aditya International",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        letterSpacing: -0.6,
                        color: Color(0xFF1A1A1A))),
                Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Color(0xFF10B981), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text("Support Portal Active",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          _buildLanguageToggle(),
        ],
      ),
    );
  }

  void _openNotifications() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FB),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  /// Handle
                  Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10))),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text("Notification Center",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 16),

                        /// FILTER ROW FIXED
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categories.map((cat) {
                              bool isSelected = activeFilter == cat;
                              return GestureDetector(
                                onTap: () {
                                  // Yahan setSheetState zaroori hai list update karne ke liye
                                  setSheetState(() {
                                    activeFilter = cat;
                                  });
                                },
                                child: _buildFilterChip(cat, isSelected),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        /// 1. Attendance Notification
                        if (activeFilter == "All" || activeFilter == "Unread")
                          _notificationTile(
                            icon: Icons.check_circle_rounded,
                            iconBg:
                                const Color(0xFFD1FAE5), // Fixed: added iconBg
                            iconColor: const Color(
                                0xFF10B981), // Fixed: added iconColor
                            title: "Attendance Marked",
                            subtitle: "Ananya has been marked Present today.",
                            time: "10m ago",
                            category: "Unread",
                            isUnread: true,
                          ),

                        /// 2. Bus Notification
                        if (activeFilter == "All" || activeFilter == "Bus")
                          _notificationTile(
                            icon: Icons.directions_bus_rounded,
                            iconBg:
                                const Color(0xFFFEF3C7), // Fixed: added iconBg
                            iconColor: const Color(
                                0xFFF59E0B), // Fixed: added iconColor
                            title: "Bus Departure",
                            subtitle: "Bus Route 5 has left. ETA: 15 mins.",
                            time: "45m ago",
                            category: "Bus",
                            isUnread: false,
                          ),

                        /// 3. Homework Notification
                        if (activeFilter == "All" || activeFilter == "Homework")
                          _notificationTile(
                            icon: Icons.assignment_rounded,
                            iconBg:
                                const Color(0xFFE0E7FF), // Fixed: added iconBg
                            iconColor: const Color(
                                0xFF4F46E5), // Fixed: added iconColor
                            title: "New Math Homework",
                            subtitle: "Exercise 5.2 due by tomorrow.",
                            time: "2h ago",
                            category: "Homework",
                            isUnread: false,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// --- Helper Components ---

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF5722) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200),
        boxShadow: isSelected
            ? [
                BoxShadow(
                    color: const Color(0xFFFF5722).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ]
            : [],
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 13),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(title,
          style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 1)),
    );
  }

  Widget _notificationTile({
    required IconData icon,
    required Color iconBg, // Yeh missing tha
    required Color iconColor, // Yeh missing tha
    required String title,
    required String subtitle, // Added back for premium feel
    required String time, // Added back for premium feel
    required String category,
    bool isUnread = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                    Text(time,
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        height: 1.4)),
              ],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(left: 8, top: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: Color(0xFFFF5722), shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryOrange,
            _primaryOrange.withBlue(40).withRed(255), // Dynamic shade
          ],
        ),
        borderRadius: BorderRadius.circular(28), // Softer corners
        boxShadow: [
          BoxShadow(
            color: _primaryOrange.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            /// Background Abstract Circles (Design Touch)
            Positioned(
              right: -20,
              top: -20,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.05),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 1. Profile Section + Notification
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      /// Avatar with Glow
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Text(
                            "AS", // Initials
                            style: TextStyle(
                              color: _primaryOrange,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      /// Student Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Ananya Sharma",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Class 8B • Roll No. 12",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: _openNotifications, // 👈 B plan
                        child: _buildHeroNotification(),
                      ),
                    ],
                  ),
                ),

                /// 2. Hero Stats Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildHeroStatPill(
                          "95%", "Attendance", Icons.check_circle_rounded),
                      const SizedBox(width: 12),
                      _buildHeroStatPill("A+", "Grade", Icons.stars_rounded),
                      const SizedBox(width: 12),
                      _buildHeroStatPill(
                          "03", "Tasks", Icons.assignment_rounded),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// 3. Bottom Date Bar (Glassmorphic)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.calendar_today_rounded,
                              color: Colors.white70, size: 14),
                          SizedBox(width: 8),
                          Text(
                            "Saturday, Nov 9, 2025",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Term 1",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: Notification Icon for Hero Section
  Widget _buildHeroNotification() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          const Icon(Icons.notifications_none_rounded,
              color: Colors.white, size: 24),
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
                border: Border.all(color: _primaryOrange, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Enhanced Stat Pill
  Widget _buildHeroStatPill(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: Color(0xFF1F2937)),
    );
  }

  Widget _buildAttendanceCard() {
    return _buildGenericCard(
      onTap: _navigateToAttendance,
      icon: Icons.analytics_rounded,
      iconColor: const Color(0xFF10B981),
      iconBg: const Color(0xFFECFDF5),
      title: "Attendance Analytics",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Monthly Rate",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              _buildStatusChip("95.5%", const Color(0xFF10B981)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.955,
              minHeight: 8,
              backgroundColor: Colors.grey.shade100,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildModernStat("21", "Present", const Color(0xFF10B981)),
              _buildModernStat("01", "Absent", const Color(0xFFEF4444)),
              _buildModernStat("22", "Total", const Color(0xFF3B82F6)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradesCard() {
    return _buildGenericCard(
      onTap: _navigateToGrades,
      icon: Icons.auto_awesome_rounded,
      iconColor: const Color(0xFFF59E0B),
      iconBg: const Color(0xFFFFF7ED),
      title: "Latest Grades",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Exam Title & Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mid-term Examination",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "October 2025",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildStatusChip("Active Term", const Color(0xFF10B981)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _showGradeRankInfo,
                    child: const Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Metric Row (Main Stats)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGradeMetric(
                  "Class Rank",
                  "3rd",
                  Icons.emoji_events_outlined,
                  const Color(0xFFF59E0B),
                ),
                _buildGradeMetric(
                  "Subjects",
                  "08",
                  Icons.book_outlined,
                  const Color(0xFF3B82F6),
                ),
                _buildGradeMetric(
                  "Overall Grade",
                  "A+",
                  Icons.grade_outlined,
                  const Color(0xFF10B981),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// ✅ Teacher Remarks (Inline – No Click Required)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.comment_rounded,
                  size: 18,
                  color: Color(0xFFF59E0B),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Excellent performance overall. Keep up the consistent effort across all subjects.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF92400E),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Avg Score Progress
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.92,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFF59E0B),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "92%",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showGradeRankInfo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final bottomSafe = MediaQuery.of(context).viewPadding.bottom;

        return Container(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            bottomSafe + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Grade vs Rank",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 14),

              /// Rank explanation
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Class Rank shows the student's position compared to classmates.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              /// Grade explanation
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.grade_outlined,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Overall Grade shows the student's performance level based on marks.",
                      style: TextStyle(fontSize: 14),
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

  /// Helper Method for Grade Metrics (Upgraded with Icons)
  Widget _buildGradeMetric(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color.withOpacity(0.7)),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHomeworkCard() {
    return _buildGenericCard(
      onTap: _navigateToHomework,
      icon: Icons.auto_stories_rounded, // Better icon for studies
      iconColor: const Color(0xFF8B5CF6),
      iconBg: const Color(0xFFF5F3FF),
      title: "Today's Homework",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Quick Stats Summary
          Row(
            children: [
              _buildHomeworkMiniStat("02 Pending", Colors.orange),
              const SizedBox(width: 8),
              _buildHomeworkMiniStat("01 Completed", Colors.green),
            ],
          ),

          const SizedBox(height: 18),

          /// Homework Items
          _buildPremiumHomeworkItem(
            subject: "Mathematics",
            topic: "Algebra: Exercise 5.2",
            dueDate: "Today, 04:00 PM",
            status: "Urgent",
            accentColor: const Color(0xFFEF4444),
          ),

          const SizedBox(height: 12),

          _buildPremiumHomeworkItem(
            subject: "Science",
            topic: "Physics: Light Reflection Lab",
            dueDate: "Tomorrow, 09:00 AM",
            status: "Pending",
            accentColor: const Color(0xFF3B82F6),
          ),

          const SizedBox(height: 16),

          /// View All Button (Subtle)
          Center(
            child: Text(
              "+2 more assignments",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for Homework Items with better visual hierarchy
  Widget _buildPremiumHomeworkItem({
    required String subject,
    required String topic,
    required String dueDate,
    required String status,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Left Accent Line
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 14),

          /// Task Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  topic,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 12, color: Colors.grey.shade400),
                    const SizedBox(width: 4),
                    Text(
                      dueDate,
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Status Badge
          _buildStatusChip(status, accentColor),
        ],
      ),
    );
  }

  Widget _buildHomeworkMiniStat(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildBusTrackingCard() {
    return _buildGenericCard(
      onTap: _navigateToBusTracking,
      icon: Icons.map_rounded,
      iconColor: const Color(0xFFF59E0B),
      iconBg: const Color(0xFFFFF7ED),
      title: "Bus Tracking",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. Bus Info & Live Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Route 05",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "• KA-AD-1234",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
              _buildTripBadge(isMorning: true),
              _buildLivePulseBadge(),
            ],
          ),

          const SizedBox(height: 20),

          /// 2. Visual Route Progress (The "Premium" touch)
          Row(
            children: [
              _buildRoutePoint(Icons.school, "School", isReached: true),
              _buildRouteLine(isActive: true),
              _buildRoutePoint(Icons.directions_bus, "Sector 12",
                  isCurrent: true),
              _buildRouteLine(isActive: false),
              _buildRoutePoint(Icons.home, "Home", isReached: false),
            ],
          ),

          const SizedBox(height: 20),

          /// 3. Speed & Driver Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                _buildBusDetail(Icons.speed, "32 km/h"),
                const VerticalDivider(width: 24),
                _buildBusDetail(Icons.person_pin, "Ravi Kumar"),
                const Spacer(),
                const Text(
                  "ETA: 15 mins",
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripBadge({required bool isMorning}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isMorning
            ? const Color(0xFFDBEAFE) // blue light
            : const Color(0xFFFFEDD5), // orange light
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isMorning ? "Morning Trip" : "Evening Trip",
        style: TextStyle(
          color: isMorning ? const Color(0xFF2563EB) : const Color(0xFFD97706),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Helper: Live Pulsing Badge
  Widget _buildLivePulseBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          const Text(
            "LIVE",
            style: TextStyle(
                color: Colors.green, fontSize: 10, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  /// Helper: Route Point UI
  Widget _buildRoutePoint(IconData icon, String label,
      {bool isReached = false, bool isCurrent = false}) {
    Color color = isCurrent
        ? const Color(0xFF3B82F6)
        : (isReached ? Colors.green : Colors.grey.shade300);
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 10, color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// Helper: Route Line UI
  Widget _buildRouteLine({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.green : Colors.grey.shade200,
      ),
    );
  }

  /// Helper: Bus Details (Speed/Driver)
  Widget _buildBusDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(text,
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildEventsCard() {
    return _buildGenericCard(
      onTap: _navigateToEvents,
      icon: Icons.event_available_rounded,
      iconColor: const Color(0xFF3B82F6),
      iconBg: const Color(0xFFEFF6FF),
      title: "Upcoming Events",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. Mini Header with Event Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Important Dates",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF64748B)),
              ),
              _buildStatusChip("3 Events", const Color(0xFF3B82F6)),
            ],
          ),

          const SizedBox(height: 16),

          /// 2. Modern Event Rows
          _buildPremiumEventRow(
            title: "Parent-Teacher Meeting",
            date: "15",
            month: "NOV",
            time: "09:30 AM",
            tag: "Mandatory",
            tagColor: const Color(0xFF10B981),
          ),

          const SizedBox(height: 12),

          _buildPremiumEventRow(
            title: "Annual Sports Day 2025",
            date: "25",
            month: "NOV",
            time: "08:00 AM",
            tag: "Cultural",
            tagColor: const Color(0xFF8B5CF6),
          ),

          const SizedBox(height: 16),

          /// 3. Subtle "Add to Calendar" Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications_active_outlined,
                  size: 14, color: Colors.grey.shade400),
              const SizedBox(width: 6),
              Text(
                "Reminders set for all events",
                style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 11,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper: Premium Event Row with Date Badge
  Widget _buildPremiumEventRow({
    required String title,
    required String date,
    required String month,
    required String time,
    required String tag,
    required Color tagColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          /// Calendar Badge
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Color(0xFF1E293B)),
                ),
                Text(
                  month,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          /// Event Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1A1A1A)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.schedule_rounded,
                        size: 12, color: Colors.grey.shade400),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    _buildStatusChip(tag, tagColor),
                  ],
                ),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios_rounded,
              size: 12, color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildSupportTicketsCard() {
    return _buildGenericCard(
      onTap: _navigateToTickets,
      icon: Icons.confirmation_number_rounded, // Ticket specific icon
      iconColor: const Color(0xFF8B5CF6),
      iconBg: const Color(0xFFF5F3FF),
      title: "Support Tickets",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. Distribution Summary Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Query Status",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF64748B)),
              ),
              Text(
                "Last updated: 2h ago",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// 2. Premium Stat Grid
          Row(
            children: [
              _buildPremiumTicketPill("01", "Active", const Color(0xFFF59E0B)),
              const SizedBox(width: 10),
              _buildPremiumTicketPill(
                  "03", "Resolved", const Color(0xFF10B981)),
              const SizedBox(width: 10),
              _buildPremiumTicketPill("04", "Total", const Color(0xFF3B82F6)),
            ],
          ),

          const SizedBox(height: 18),

          /// 3. Recent Activity / Quick Action
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.add_comment_rounded,
                      size: 16, color: Color(0xFF8B5CF6)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Have a new concern? Raise a ticket.",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF475569)),
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded,
                    size: 14, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Premium Ticket Pill with Depth
  Widget _buildPremiumTicketPill(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Icon(Icons.translate, size: 14, color: _primaryOrange),
            const SizedBox(width: 4),
            Text(_selectedLanguage,
                style: TextStyle(
                    color: _primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _navigateToTodayFullDetails() {
    Navigator.pushNamed(
      context,
      ParentsRoutes.todayFullDetails,
    );
  }

  /// --- Status Chip (Label with Background) ---
  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  /// --- Modern Stat (Big Number with Label) ---
  Widget _buildModernStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _todayHomeworkItem({
    required String subject,
    required String title,
    required String badgeText,
    required Color badgeBg,
    required Color badgeColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bullet
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: badgeColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),

        // Homework text
        Expanded(
          child: Text(
            "$subject – $title",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
        ),

        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            badgeText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: badgeColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ticketStatPill({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

// --- TODAY'S SUMMARY TILE ---
  Widget _buildTodaySummaryTile() {
    return Container(
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
          /// 🔹 Header
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
              GestureDetector(
                onTap: () => _openCalendarPicker(context),
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white.withOpacity(0.9),
                  size: 22,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// 🔹 Summary Rows
          Column(
            children: [
              // Attendance
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AttendanceRecordPage(),
                    ),
                  );
                },
                child: _buildSummaryRow(
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
              ),
              const SizedBox(height: 10),

              // Morning Bus
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BusTrackingPage(),
                    ),
                  );
                },
                child: _buildSummaryRow(
                  icon: Icons.directions_bus,
                  iconBg: const Color(0xFFF59E0B),
                  title: "Morning Bus",
                  subtitle: "Reached School",
                  rightWidget: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                      ),
                    ),
                    child: const Text(
                      "On Time",
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Today's Schedule → Bus Tracking
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ClassTimetablePage(
                        classData: {
                          'className': 'Class 5 - A',
                          'classTeacher': 'Mrs. Anita Desai',
                          'totalStudents': '42',
                          'room': 'Room 101',
                          'floor': '1st Floor',
                          'section': 'A',
                        },
                      ),
                    ),
                  );
                },
                child: _buildSummaryRow(
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
              ),
              const SizedBox(height: 10),

              // Homework
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeworkPage(),
                    ),
                  );
                },
                child: _buildSummaryRow(
                  icon: Icons.assignment_outlined,
                  iconBg: const Color(0xFFEC4899),
                  title: "Homework",
                  subtitle: "1 Assignment Due",
                  rightWidget: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFEF4444).withOpacity(0.3),
                      ),
                    ),
                    child: const Text(
                      "Today",
                      style: TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Today's Event
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EventsPage(),
                    ),
                  );
                },
                child: _buildSummaryRow(
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
              ),
              const SizedBox(height: 10),

              // Evening Bus
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BusTrackingPage(),
                    ),
                  );
                },
                child: _buildSummaryRow(
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
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// ✅ View Full Details button
          GestureDetector(
            onTap: _navigateToTodayFullDetails,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(12),
              ),
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
              const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Color(0xFFDC2626), size: 20),
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
                child:
                    const Icon(Icons.close, size: 18, color: Color(0xFF7F1D1D)),
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

  Future<void> _openCalendarPicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      print("Selected date: $pickedDate");
      // 👉 yahan selected date ka data load karwa sakta hai
    }
  }

  Widget _buildGenericCard({
    required VoidCallback onTap,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // Modern soft corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: iconBg.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header Section
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: iconBg,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: iconColor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: -0.5,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.grey.shade300, size: 14),
                    ],
                  ),

                  const SizedBox(height: 18),

                  /// Content Area (No divider, just spacing)
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventRow(String title, String date) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // Subtle background for the row
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Date Badge Icon
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.calendar_today_rounded,
                size: 16, color: _headerOrange),
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Date Text
          Text(
            date,
            style: TextStyle(
              color: _headerOrange,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Update item widget
  Widget _buildUpdateItem(
      {required bool isNew, required String time, required String text}) {
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
