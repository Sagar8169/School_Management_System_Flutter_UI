import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

// --- Color and Style Definitions ---
const Color primaryBlue = Color(0xFF2E4072);
const Color alertRed = Color(0xFFC70039);
const Color successGreen = Color(0xFF4CAF50);
const Color iconColor = Color(0xFF42A5F5);
const Color cardBackgroundColor = Color(0xFFFFFFFF);
const Color dividerColor = Color(0xFFE0E0E0);
const Color appBackground = Color(0xFFF7F7F7);

// --- Utility Functions ---
String limitText(String text, int maxChars) {
  if (text.length <= maxChars) return text;
  return text.substring(0, maxChars) + "...";
}

String _weekday(int w) {
  const days = ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  return days[w];
}

String _month(int m) {
  const months = [
    "", "January", "February", "March", "April", "May", "June",
    "July", "August", "September",
    "October", "November", "December"
  ];
  return months[m];
}

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({Key? key}) : super(key: key);

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  int _currentIndex = 0;
  bool _showAlert = true;
  bool _isTelugu = true;

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // Already on home - scroll to top if needed
        break;
      case 1:
        Navigator.pushNamed(context, PrincipalRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  void _openMoreSection(String sectionKey) {
    Navigator.pushNamed(
      context,
      PrincipalRoutes.morePage,
      arguments: {'section': sectionKey},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with Principal Info and Overview
              _buildPrincipalHeader(),

              // 2. Cyclone Alert
              if (_showAlert) _buildCycloneAlertBanner(),

              // 3. Attendance Overview
              _buildAttendanceOverviewCard(),

              // 4. Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        title: 'Take Attendance',
                        subtitle: 'Any Class',
                        icon: Icons.calendar_month_outlined,
                        iconBgColor: const Color(0xFF64D2A3),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, PrincipalRoutes.takeAttendance);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionCard(
                        title: 'Upload Grades',
                        subtitle: 'Any Class',
                        icon: Icons.star_border,
                        iconBgColor: const Color(0xFF8E44FF),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, PrincipalRoutes.uploadGrades);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 5. Grades Analytics
              _buildGradesAnalyticsCard(),

              // 6. Pending Approvals
              _buildPendingApprovalsCard(),

              // 7. Tickets
              _buildTicketsCard(),

              // 8. Upcoming Events
              _buildUpcomingEventsCard(),

              // 9. Fleet Management
              _buildFleetManagementCard(),

              // 10. Secondary Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionCard2(
                        title: 'Manage Timetable',
                        subtitle: 'All Classes',
                        icon: Icons.calendar_month_outlined,
                        iconBgColor: const Color(0xFF4A3AFF),
                        iconColor: Colors.white,
                        onTap: () {
                          // Navigate to Timetable Page instead of More section
                          Navigator.pushNamed(context, PrincipalRoutes.timetable);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionCard2(
                        title: 'Announcements',
                        subtitle: 'To Teachers',
                        icon: Icons.chat_bubble_outline,
                        iconBgColor: const Color(0xFFE64A19),
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, PrincipalRoutes.announcements);
                        },
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPrincipalHeader() {
    return Column(
      children: [
        // ------------------ TOP WHITE APP BAR ------------------
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // School Logo
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xff4E7CF9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // School Title & Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    limitText("Aditya International School", 25),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Powered by Toki Tech",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Language Button
              GestureDetector(
                onTap: _toggleLanguage,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    _isTelugu ? "తెలుగు" : "English",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ------------------ BLUE HEADER SECTION ------------------
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff4A7BFF),
                Color(0xff3366FF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _liveDateTimeRow(),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Welcome, Dr. Ramesh Sharma",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // ------------------ Stats Card ------------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _OverviewStat(value: '850', label: 'Total Students'),
                    _OverviewStat(value: '45', label: 'Total Teachers'),
                    _OverviewStat(value: '20', label: 'Total Classes'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _liveDateTimeRow() {
    final now = DateTime.now();
    final formattedDate = "${_weekday(now.weekday)}, ${_month(now.month)} ${now.day}, ${now.year}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LEFT: DATE
        Text(
          formattedDate,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        // RIGHT: PRINCIPAL BUTTON STYLE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: const Text(
            "Principal",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCycloneAlertBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      padding: const EdgeInsets.fromLTRB(16, 14, 14, 16),
      decoration: BoxDecoration(
        color: const Color(0xffFDF3F3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffE9B8B8),
          width: 1.4,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: Color(0xffD74343),
            size: 24,
          ),

          const SizedBox(width: 12),

          // MAIN TEXT AREA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Cyclone Alert - School Closed",
                  style: TextStyle(
                    color: Color(0xff1D1D1F),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Due to severe cyclone warning, school will remain closed on October 21–22, 2025. Stay safe!",
                  style: TextStyle(
                    color: Color(0xff4A4A4A),
                    fontSize: 14,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          // CLOSE BUTTON
          GestureDetector(
            onTap: () {
              setState(() {
                _showAlert = false;
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10, top: 2),
              child: Icon(
                Icons.close,
                size: 20,
                color: Color(0xff555555),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceOverviewCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PrincipalRoutes.attendanceAnalytics);
        },
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 20, color: Colors.green.shade600),
                const SizedBox(width: 8),
                const Text(
                  "Attendance Overview",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9F7EF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statBlock("798", "Present", Colors.green.shade600),
                _statBlock("52", "Absent", Colors.red.shade600),
                _statBlock("94%", "Rate", Colors.black87),
              ],
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                "View Details  >",
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _statBlock(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildGradesAnalyticsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PrincipalRoutes.gradesAnalytics);
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.show_chart_rounded,
                    size: 22, color: Colors.blue.shade600),
                const SizedBox(width: 10),
                const Text(
                  "Grades Analytics",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "unit exam",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6C6C6C),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 28),

            Row(
              children: const [
                Text(
                  "Average Performance",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                Spacer(),
                Text(
                  "82%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: const [
                Text(
                  "All Class Average",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                Spacer(),
                Text(
                  "78.5%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "View Details",
                    style: TextStyle(
                      fontSize: 15,
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios,
                      size: 14, color: iconColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingApprovalsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PrincipalRoutes.pendingApprovals);
        },
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon + Title + Total Badge
            Row(
              children: [
                Icon(Icons.check_box_outlined,
                    color: const Color(0xFFE65100), size: 26),
                const SizedBox(width: 10),
                const Text(
                  "Pending Approvals",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE65100),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "10",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            const SizedBox(height: 22),

            // Grade Approvals Row
            _approvalRow(
              title: "Grade Approvals",
              count: "3",
              color: const Color(0xFFE65100),
            ),

            const SizedBox(height: 14),

            // Attendance Approvals Row
            _approvalRow(
              title: "Attendance Approvals",
              count: "7",
              color: const Color(0xFF2962FF),
            ),

            const SizedBox(height: 18),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 15,
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _approvalRow({
    required String title,
    required String count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _openMoreSection('tickets');
        },
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon + Title + Count Badge
            Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 26,
                  color: const Color(0xFFD32F2F),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Tickets",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD32F2F),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "8",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Raised Tickets Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              child: Row(
                children: [
                  const Text(
                    "Raised Tickets",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD32F2F),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "5",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // In Progress Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              child: Row(
                children: [
                  const Text(
                    "In Progress",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFBF7B19),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _openMoreSection('events');
        },
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Icon(Icons.calendar_month_outlined,
                    size: 26, color: const Color(0xFF673AB7)),
                const SizedBox(width: 10),
                const Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // EVENT 1
            _eventRow(
              month: "Nov",
              day: "15",
              title: "Annual Sports Day",
              description: "Annual sports day celebration with various competitions",
            ),

            const SizedBox(height: 14),

            // EVENT 2
            _eventRow(
              month: "Nov",
              day: "20",
              title: "Parent-Teacher Meeting",
              description: "Monthly parent-teacher meeting to discuss student progress",
            ),

            const SizedBox(height: 14),

            // EVENT 3
            _eventRow(
              month: "Nov",
              day: "25",
              title: "Science Exhibition",
              description: "Students showcase their science projects and experiments",
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventRow({
    required String month,
    required String day,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DATE
          SizedBox(
            width: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(month,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(
                  day,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // TITLE + DESCRIPTION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFleetManagementCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PrincipalRoutes.fleetManagement);
        },
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Icon(Icons.directions_bus_filled_outlined,
                    size: 26, color: const Color(0xFFE65100)),
                const SizedBox(width: 10),
                const Text(
                  "Fleet Management",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Total Buses
            Row(
              children: const [
                Text(
                  "Total Buses",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                Spacer(),
                Text(
                  "6",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Active Trips
            Row(
              children: [
                const Text(
                  "Active Trips",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "4",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // View Details
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "View Details",
                    style: TextStyle(
                      fontSize: 15,
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios,
                      size: 14, color: iconColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class _OverviewStat extends StatelessWidget {
  final String value;
  final String label;

  const _OverviewStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard2 extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard2({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.black12, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon,
                  size: 28, color: iconColor),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}