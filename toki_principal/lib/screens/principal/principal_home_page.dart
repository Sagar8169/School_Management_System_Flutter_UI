import 'package:flutter/material.dart';
import 'package:toki_principal/routes/principal_routes.dart';
import 'package:toki_principal/screens/principal/notifications_page.dart';
import 'package:toki_principal/screens/principal/tickets_page.dart';
import 'package:toki_principal/screens/principal/timetable_page.dart';

class PrincipalHomePage extends StatefulWidget {
  const PrincipalHomePage({super.key});

  @override
  State<PrincipalHomePage> createState() => _PrincipalHomePageState();
}

class _PrincipalHomePageState extends State<PrincipalHomePage> {
  Color themeBlue = Color(0xFF1E3A8A);
  Color themeLightBlue = Color(0xFF3B82F6);
  Color themeGreen = Color(0xFF059669);
  Color backgroundSlate = Color(0xFFF8FAFC);
  bool _showAlert = true;

  bool _isTelugu = true;

  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final double horizontalPadding =
        screenWidth > 600 ? screenWidth * 0.1 : 20.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    // 1. Principal Header Section
                    _buildPremiumHero(horizontalPadding),
                    const SizedBox(height: 20),
                    // 2. Cyclone Alert Banner
                    if (_showAlert)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _premiumAlertBanner(
                          title: 'Cyclone Alert - School Closed',
                          message:
                              'Due to severe cyclone warning, school remains closed. Stay safe!',
                          onDismiss: () => setState(() => _showAlert = false),
                        ),
                      ),

                    // 3. Attendance Overview (Now on top of buttons)
                    _buildAttendanceOverviewCard(),

                    // 4. Action Buttons (Take Attendance & Upload Grades)
                    _buildMainActions(),

                    const SizedBox(height: 10),

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
                    _buildSecondaryTools(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [themeBlue, themeLightBlue]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
                child: Text("A",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Aditya International School",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E293B))),
                  Text("Powered by Toki Tech",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                ]),
          ),
          _langTogglePill(),
        ],
      ),
    );
  }

  Widget _langTogglePill() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Text(_isTelugu ? "తెలుగు" : "English",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3B82F6))),
      ),
    );
  }

  Widget _buildPremiumHero(double px) {
    const Color primaryBlue = Color(0xFF2563EB);
    const Color lightBlue = Color(0xFF3B82F6);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(px, 16, px, 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBlue, lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP BAR ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "WEDNESDAY, DEC 24",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              _premiumBadge(),
            ],
          ),

          const SizedBox(height: 20),

          // --- WELCOME + NOTIFICATION ROW ---
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELCOME BACK,",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      "Dr. Ramesh Sharma",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔔 Notification Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotificationsPage(),
                    ),
                  );
                },
                child: Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.12),
                    border: Border.all(color: Colors.white24, width: 1.5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- STATS BOARD (Premium Glass UI) ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.22),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                _premiumStat(
                  value: "850",
                  label: "Students",
                ),
                _glassDivider(),
                _premiumStat(
                  value: "45",
                  label: "Teachers",
                ),
                _glassDivider(),
                _premiumStat(
                  value: "20",
                  label: "Classes",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _premiumStat({
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassDivider() {
    return Container(
      height: 40,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

// Compact Stat Widget
  Widget _compactStat(String val, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            val,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

// Minimalist Divider
  Widget _miniDivider() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.white.withOpacity(0.15),
    );
  }

// Stats Widget
  Widget _modernHeroStat(String val, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        const SizedBox(height: 8),
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

// Vertical Divider
  Widget _customDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withOpacity(0.15),
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _heroStat(String v, String l) => Column(children: [
        Text(v,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(l, style: const TextStyle(color: Colors.white70, fontSize: 11))
      ]);

  Widget _premiumBadge() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)),
      child: const Text("Principal",
          style: TextStyle(
              color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold)));

  // 3. Attendance Overview (Updated with Borders)
  // 3. Attendance Overview (Updated with 12px All-side Padding/Margin)
  Widget _buildAttendanceOverviewCard() {
    return Container(
      // All sides se 12 ki padding/margin de di hai
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // --- SUBTLE BORDER ---
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, PrincipalRoutes.attendanceAnalytics),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20), // Card ke andar ki spacing
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: themeGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.calendar_today_rounded,
                        size: 16, color: themeGreen),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Attendance Overview",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: Color(0xFF94A3B8)),
                ],
              ),
              const SizedBox(height: 24),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _miniStat("798", "Present", themeGreen),
                  _buildStatDivider(),
                  _miniStat("52", "Absent", Colors.redAccent),
                  _buildStatDivider(),
                  _miniStat("94%", "Rate", const Color(0xFF1E293B)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// Stats Divider (Light & Clean)
  Widget _buildStatDivider() {
    return Container(
      height: 32,
      width: 1.2,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

// Stats ke beech mein halki vertical line

  Widget _miniStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              letterSpacing: 0.5),
        ),
      ],
    );
  }

  // 4. Action Buttons (Take Attendance & Upload Grades)
  Widget _buildMainActions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        Expanded(
            child: _ActionBox(
                title: "Take Attendance",
                sub: "Any Class",
                icon: Icons.calendar_month_outlined,
                color: const Color(0xFF64D2A3),
                onTap: () => Navigator.pushNamed(
                    context, PrincipalRoutes.takeAttendance))),
        const SizedBox(width: 15),
        Expanded(
            child: _ActionBox(
                title: "Upload Grades",
                sub: "Any Class",
                icon: Icons.star_border,
                color: const Color(0xFF8E44FF),
                onTap: () => Navigator.pushNamed(
                    context, PrincipalRoutes.uploadGrades))),
      ]),
    );
  }

  Widget _buildGradesAnalyticsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        // --- PREMIUM SUBTLE SHADOW & BORDER ---
        border: Border.all(
          color: const Color(0xFFE2E8F0), // slate-200
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, PrincipalRoutes.gradesAnalytics),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- HEADER SECTION ---
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.show_chart_rounded,
                          size: 20, color: Colors.blue),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        "Grades Analytics",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color(0xFF0F172A)),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: Color(0xFFCBD5E1)),
                  ],
                ),

                const SizedBox(height: 25),

                // --- INSIGHTS SECTION (Visual Progress Style) ---
                _rowInsightUI(Icons.trending_up_rounded, "Average Performance",
                    "82%", Colors.green, 0.82),
                const SizedBox(height: 18),
                _rowInsightUI(Icons.analytics_outlined, "All Class Average",
                    "78.5%", Colors.blue, 0.78),
              ],
            ),
          ),
        ),
      ),
    );
  }

// --- UPDATED ROW INSIGHT WITH PROGRESS BAR ---
  Widget _rowInsightUI(
      IconData icon, String title, String value, Color color, double progress) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color.withOpacity(0.7)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B)),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w900, color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Visual Progress Indicator (UI only, no text change)
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }

// Analytics Insight Row Widget
  Widget _rowInsight(
      IconData icon, String label, String value, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // Very light grey bg
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey.shade400),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B)),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w900, color: statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingApprovalsCard() {
    const double radius = 36;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius), // ✅ OUTER RADIUS
        border: Border.all(
          color: const Color(0xFFE2E8F0), // slate-200
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFFE65100).withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius), // ✅ CLIP SAME RADIUS
        child: InkWell(
          borderRadius: BorderRadius.circular(radius), // ✅ RIPPLE SAME RADIUS
          onTap: () => Navigator.pushNamed(
            context,
            PrincipalRoutes.pendingApprovals,
          ),
          child: Column(
            children: [
              // --- TOP CONTENT ---
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon Box
                              Container(
                                height: 54,
                                width: 54,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFF7ED),
                                      Color(0xFFFFEDD5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.auto_awesome_motion_rounded,
                                  size: 26,
                                  color: Color(0xFFE65100),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Approval Center",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 19,
                                        color: Color(0xFF1E293B),
                                        letterSpacing: -0.8,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Action required for 10 mins",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Badge
                        _buildGlassBadge("10"),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // --- STATS ROW ---
                    Row(
                      children: [
                        _buildModernApprovalTile(
                          "Grades",
                          "03",
                          const Color(0xFFE65100),
                          Icons.analytics_rounded,
                        ),
                        const SizedBox(width: 14),
                        _buildModernApprovalTile(
                          "Attendance",
                          "07",
                          const Color(0xFF2563EB),
                          Icons.event_available_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --- FOOTER ---
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF8FAFC),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border(
                    top: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "REVIEW ALL PENDING",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2563EB),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: const Color(0xFF2563EB).withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Custom Badge Widget
  Widget _buildGlassBadge(String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFEE2E2)),
      ),
      child: Text(
        "$count NEW",
        style: const TextStyle(
            color: Color(0xFFDC2626),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5),
      ),
    );
  }

// Modern Tile Helper
  Widget _buildModernApprovalTile(
      String label, String count, Color themeColor, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 18, color: themeColor),
                Text(
                  count,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: themeColor,
                      fontFamily:
                          'monospace'), // Monospace gives a data-heavy feel
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.0),
            ),
          ],
        ),
      ),
    );
  }

// --- HELPER WIDGET: APPROVAL TILE ---
  Widget _buildApprovalTile(
      String label, String count, Color themeColor, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: themeColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: themeColor.withOpacity(0.12), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 18, color: themeColor.withOpacity(0.7)),
                // Micro-dot indicator
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: themeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: themeColor.withOpacity(0.4),
                          blurRadius: 4,
                          spreadRadius: 1)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              count,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: themeColor,
                letterSpacing: -1,
              ),
            ),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: themeColor.withOpacity(0.6),
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Custom Row for Approvals
  Widget _approvalRow(String label, String count, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration:
                BoxDecoration(color: accentColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF475569)),
          ),
          const Spacer(),
          Text(
            count,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w900, color: accentColor),
          ),
        ],
      ),
    );
  }

  // 7. Tickets
  Widget _buildTicketsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE2E8F0), // slate-200
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD32F2F).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            PrincipalRoutes.ticketsPage,
          ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                // --- HEADER: TITLE & TOTAL INDICATOR ---
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2), // Very Light Red
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.confirmation_number_rounded,
                          size: 20, color: Color(0xFFD32F2F)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Support Desk",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Color(0xFF0F172A)),
                          ),
                          Text(
                            "Needs your attention",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                    // Premium Click Indicator
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 14, color: Color(0xFFCBD5E1)),
                  ],
                ),

                const SizedBox(height: 24),

                // --- STATUS GRID: HORIZONTAL SPLIT ---
                Row(
                  children: [
                    _ticketStatTile(
                        "05", "Open Issues", const Color(0xFFEF4444)),
                    const SizedBox(width: 12),
                    _ticketStatTile(
                        "03", "In Progress", const Color(0xFFF59E0B)),
                  ],
                ),

                const SizedBox(height: 18),

                // --- RECENT TICKET PREVIEW ---
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.priority_high_rounded,
                          size: 14, color: Color(0xFFEF4444)),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Latest: Lab PC Maintenance Issue",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF475569)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "Critical",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFFEF4444).withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Helper: Modern Stat Tile
  Widget _ticketStatTile(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count,
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w900, color: color),
            ),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: color.withOpacity(0.7),
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

// Custom Row for Ticket Status
  Widget _ticketStatusRow(String label, String count, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(
            accentColor == Colors.orange
                ? Icons.hourglass_top_rounded
                : Icons.fiber_new_rounded,
            size: 16,
            color: accentColor,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF475569)),
          ),
          const Spacer(),
          Text(
            count,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w900, color: accentColor),
          ),
        ],
      ),
    );
  }

// Helper for the Pill (make sure this is available)
  Widget _countPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildUpcomingEventsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE2E8F0), // slate-200
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, PrincipalRoutes.timetable),
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              // --- HEADER SECTION ---
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.auto_awesome_rounded,
                        size: 20, color: Color(0xFF6366F1)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upcoming Events",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Color(0xFF0F172A)),
                        ),
                        Text(
                          "Don't miss out on important dates",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  // Clickable Indicator
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward_ios_rounded,
                        size: 12, color: Color(0xFF6366F1)),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // --- MODERN EVENT TIMELINE ---
              _modernEventTile("25", "DEC", "Christmas Celebration",
                  "School Auditorium", const Color(0xFF6366F1)),
              const Padding(
                padding: EdgeInsets.only(left: 60, top: 12, bottom: 12),
                child: Divider(
                    height: 1, color: Color(0xFFF1F5F9), thickness: 1.2),
              ),
              _modernEventTile("01", "JAN", "New Year Assembly",
                  "Central Plaza", const Color(0xFF8B5CF6)),
            ],
          ),
        ),
      ),
    );
  }

// Helper: Calendar Style Event Tile
  Widget _modernEventTile(
      String day, String month, String title, String loc, Color themeColor) {
    return Row(
      children: [
        // Calendar Badge
        Container(
          width: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: themeColor.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Text(
                day,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: themeColor),
              ),
              Text(
                month,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: themeColor.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Event Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on_rounded,
                      size: 12, color: Colors.grey.shade400),
                  const SizedBox(width: 4),
                  Text(
                    loc,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Tiny Status Indicator
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              color: themeColor.withOpacity(0.4), shape: BoxShape.circle),
        ),
      ],
    );
  }

// Custom Premium Event Row
  Widget _premiumEventRow(String date, String title, String venue) {
    return Row(
      children: [
        // Date Pill
        Container(
          width: 55,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF673AB7).withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF673AB7).withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Text(
                date.split(" ")[0], // Nov
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF673AB7)),
              ),
              Text(
                date.split(" ")[1], // 15
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF673AB7)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),

        // Event Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 11, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    venue,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFleetManagementCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // ✨ Background clean white kar diya
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFE2E8F0), // slate-200
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, PrincipalRoutes.fleetManagement),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                // --- HEADER SECTION ---
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5), // Soft Emerald Tint
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.local_shipping_rounded,
                          size: 22, color: Color(0xFF059669)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fleet Manager",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.5),
                          ),
                          Text(
                            "Tracking 8 Vehicles",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                    // --- CLICK INDICATOR ---
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFC), shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 12, color: Color(0xFF059669)),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // --- METRICS ROW (CLEAN CARDS) ---
                Row(
                  children: [
                    _buildCleanStat("04", "Active", const Color(0xFF059669)),
                    const SizedBox(width: 10),
                    _buildCleanStat("03", "Idle", const Color(0xFFF59E0B)),
                    const SizedBox(width: 10),
                    _buildCleanStat("01", "Alert", const Color(0xFFEF4444)),
                  ],
                ),

                const SizedBox(height: 20),

                // --- TRIP PROGRESS SECTION ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Daily Trip Progress",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF64748B)),
                          ),
                          Text(
                            "75%",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF059669)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF059669)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// --- SUB-WIDGET: CLEAN STAT TILE ---
  Widget _buildCleanStat(String value, String label, Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.06), // Very light tint
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: accent),
            ),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: accent.withOpacity(0.7),
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

// --- SUB-WIDGET: HARA STAT TILE ---
  Widget _buildHaraStat(String value, String label, Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: accent),
            ),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Colors.white60,
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  // 10. Secondary Actions
  Widget _buildSecondaryTools() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(children: [
        Expanded(
            child: _ActionBox(
                title: "Manage Timetable",
                sub: "All Classes",
                icon: Icons.calendar_month_outlined,
                color: const Color(0xFF4A3AFF),
                onTap: () =>
                    Navigator.pushNamed(context, PrincipalRoutes.timetable))),
        const SizedBox(width: 15),
        Expanded(
            child: _ActionBox(
                title: "Announcements",
                sub: "To Teachers",
                icon: Icons.chat_bubble_outline,
                color: const Color(0xFFE64A19),
                onTap: () => Navigator.pushNamed(
                    context, PrincipalRoutes.announcements))),
      ]),
    );
  }

  Widget _premiumAlertBanner({
    required String title,
    required String message,
    required VoidCallback onDismiss,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2), // soft red background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFECACA), // light red border
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔴 Accent strip
          Container(
            width: 4,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFDC2626),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 12),

          // ⚠️ Icon bubble
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFDC2626),
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          // 📝 Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF7F1D1D),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF7F1D1D),
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          // ❌ Close
          GestureDetector(
            onTap: onDismiss,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Color(0xFF7F1D1D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycloneAlertBanner() {
    if (!_showAlert) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED), // soft warning bg
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFEA580C),
            size: 22,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "cyclone alert: school will remain closed on oct 21–22. please stay safe.",
              style: TextStyle(
                color: Color(0xFF9A3412),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _showAlert = false),
            child: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Icon(
                Icons.close,
                size: 18,
                color: Color(0xFF9A3412),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _baseCard(
      {required String title,
      required IconData icon,
      required Color color,
      required Widget child,
      Widget? trailing,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 18)),
              const SizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                      fontSize: 15)),
              const Spacer(),
              trailing ??
                  const Icon(Icons.arrow_forward_ios,
                      size: 12, color: Color(0xFFCBD5E1)),
            ]),
            const SizedBox(height: 20),
            child,
          ]),
        ),
      ),
    );
  }

  Widget _tag(String l, Color c) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(l,
          style:
              TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.w900)));

  Widget _eventRow(String d, String t) => Row(children: [
        Container(
            width: 50,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.event, size: 16, color: themeBlue)),
        const SizedBox(width: 12),
        Text(t,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color(0xFF1E293B)))
      ]);
}

class _ActionBox extends StatelessWidget {
  final String title, sub;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionBox(
      {required this.title,
      required this.sub,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10))
            ]),
        child: Column(children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: Colors.white, size: 28)),
          const SizedBox(height: 12),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E293B))),
          Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ]),
      ),
    );
  }
}
