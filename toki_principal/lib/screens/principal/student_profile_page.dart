import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class StudentProfilePage extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const StudentProfilePage({super.key, required this.studentData});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  // int _currentIndex = 1;
  bool _isTelugu = true;

  // --- ORIGINAL DATA (Unchanged) ---
  final List<Map<String, dynamic>> _subjectsPerformance = [
    {'subject': 'Mathematics', 'score': 42, 'status': 'Critical'},
    {'subject': 'Science', 'score': 38, 'status': 'Critical'},
    {'subject': 'English', 'score': 55, 'status': 'Average'},
    {'subject': 'Hindi', 'score': 62, 'status': 'Good'},
    {'subject': 'Social Studies', 'score': 48, 'status': 'Critical'},
  ];

  bool get _isCritical => widget.studentData['isCritical'] as bool;

  // --- ORIGINAL FUNCTIONS (Unchanged) ---
  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // void _onBottomNavTap(int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
  //       break;
  //     case 1:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
  //       break;
  //     case 2:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         PrincipalRoutes.morePage,
  //         arguments: {'section': null},
  //       );
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ✨ PREMIUM HEADER: "Student Profile" moved inside header with back button
            _buildMainPremiumHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ✨ PREMIUM PROFILE CARD (Adaptive Gradient)
                    _buildPremiumStudentCard(),

                    const SizedBox(height: 24),

                    // ✨ ACADEMIC STATS
                    _buildAcademicStats(),

                    const SizedBox(height: 24),

                    // ✨ PERFORMANCE LIST
                    _buildSubjectPerformanceList(),

                    const SizedBox(height: 24),

                    // ✨ PARENT INFORMATION
                    _buildInfoSection("Parent Information",
                        Icons.family_restroom_rounded, _buildParentDetails()),

                    const SizedBox(height: 30),

                    // ✨ ACTION BUTTONS
                    _buildActionButtons(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // --- ✨ COMPACT HEADER (Screenshot Style) ---
  Widget _buildMainPremiumHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: Color(0xFF1E293B)),
          ),
          const SizedBox(width: 16),
          // Title Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Student Profile', // ✨ Header Text
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B)),
                ),
                Text(
                  'Aditya International School',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          // Language Pill
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English',
                  style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontWeight: FontWeight.w800,
                      fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumStudentCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isCritical
              ? [const Color(0xFFE11D48), const Color(0xFFBE123C)]
              : [const Color(0xFF1D4ED8), const Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: (_isCritical ? Colors.red : Colors.blue).withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18)),
                child: const Icon(Icons.person_rounded,
                    size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.studentData['name'],
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    Text("Class: ${widget.studentData['grade']} • Roll: 15",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(_isCritical ? 'CRITICAL' : 'STABLE',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Divider(height: 1, color: Colors.white24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCompactInfo(
                  "STUDENT ID", widget.studentData['id'] ?? 'N/A'),
              _buildCompactInfo("ACADEMIC YEAR", "2024-25"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                color: Colors.white70,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
      ],
    );
  }

// Inside _StudentProfilePageState

  Widget _buildAcademicStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _navigateTo(PrincipalRoutes.gradesAnalytics,
                arguments: {'studentData': widget.studentData}),
            child: _statBox("${widget.studentData['avgGrade']}%", "Avg Grade",
                _getGradeColor(widget.studentData['avgGrade'])),
          ),
          GestureDetector(
            onTap: () => _navigateTo(PrincipalRoutes.attendanceAnalytics,
                arguments: {'studentData': widget.studentData}),
            child: _statBox(
                "${widget.studentData['attendance']}%",
                "Attendance",
                _getAttendanceColor(widget.studentData['attendance'])),
          ),
        ],
      ),
    );
  }

  Widget _statBox(String value, String label, Color color) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),

        // 🌟 CLEAN LIGHT BORDER
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),

        // 🌟 SOFT FLOATING SHADOW
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.025),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectPerformanceList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER: TITLE & ACTION ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subject Analytics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Subject-wise scoring trend",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
                _buildViewMoreBtn(),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- PERFORMANCE CARD ---
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),

              // 🌟 LIGHT & CLEAN BORDER
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),

              // 🌟 SOFT PREMIUM SHADOW
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E293B).withOpacity(0.025),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: _subjectsPerformance.asMap().entries.map((entry) {
                final int idx = entry.key;
                final Map<String, dynamic> s = entry.value;

                return Column(
                  children: [
                    _buildModernSubjectRow(s),

                    // --- SOFT DIVIDER ---
                    if (idx != _subjectsPerformance.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 1,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xFFE2E8F0),
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

// ✨ MODERN DATA ROW WITH FLOATING CAPSULE PROGRESS
  Widget _buildModernSubjectRow(Map<String, dynamic> s) {
    final double score = double.tryParse(s['score'].toString()) ?? 0.0;
    final double progress = score / 100;

    // Status Logic
    final Color statusColor = score >= 80
        ? const Color(0xFF10B981)
        : (score >= 50 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));
    final String statusText =
        score >= 80 ? "Exceeding" : (score >= 50 ? "Average" : "Critical");

    return Column(
      children: [
        Row(
          children: [
            // Icon Avatar with Depth
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: statusColor.withOpacity(0.12)),
              ),
              child: Center(
                child: Text(
                  s['subject'].toString()[0].toUpperCase(),
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Subject Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['subject'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Color(0xFF1E293B)),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: statusColor.withOpacity(0.8),
                        letterSpacing: 0.3),
                  ),
                ],
              ),
            ),
            // Score Label
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${score.toInt()}%",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      color: statusColor,
                      letterSpacing: -0.5),
                ),
                const Text("SCORE",
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFCBD5E1))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Glass-Style Floating Progress Bar
        Stack(
          children: [
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              height: 8,
              width: (MediaQuery.of(context).size.width - 84) *
                  progress, // Responsive calculation
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [statusColor, statusColor.withOpacity(0.7)],
                ),
                boxShadow: [
                  BoxShadow(
                      color: statusColor.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

// Custom View More Button
  Widget _buildViewMoreBtn() {
    return InkWell(
      onTap: () => _navigateTo(PrincipalRoutes.gradesAnalytics,
          arguments: {'studentData': widget.studentData}),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A), // Dark Executive Color
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Text("Trends",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 10)),
            SizedBox(width: 6),
            Icon(Icons.trending_up_rounded, size: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }

// ✨ PREMIUM SUBJECT ROW WITH PROGRESS BAR
  Widget _buildSubjectProgressRow(Map<String, dynamic> s) {
    final double score = double.parse(s['score'].toString());
    final double progress = score / 100;

    // Dynamic color based on score
    final Color statusColor = score >= 80
        ? const Color(0xFF10B981)
        : (score >= 50 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      s['subject'].toString()[0].toUpperCase(),
                      style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  s['subject'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: Color(0xFF334155)),
                ),
              ],
            ),
            Text(
              "$score%",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: statusColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Visual Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectRow(Map<String, dynamic> s) {
    Color c = _getGradeColor(s['score'].toDouble());
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['subject'],
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 4),
            Text(s['status'],
                style: TextStyle(
                    color: c,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5)),
          ]),
          Text("${s['score']}%",
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w900, color: c)),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, IconData icon, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- SECTION HEADER ---
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: const Color(0xFF1D4ED8),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF334155),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // --- CONTENT CARD ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),

              // 🌟 LIGHT PREMIUM BORDER
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),

              // 🌟 SOFT DEPTH
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E293B).withOpacity(0.025),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildParentDetails() {
    return Column(
      children: [
        _dataRow("Father's Name", "Mr. Suresh Singh"),
        _softDivider(),
        _dataRow("Primary Contact", "+91 98765 43210"),
        _softDivider(),
        _dataRow("Birth Date", "15 March 2010"),
      ],
    );
  }

  Widget _softDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFF1F5F9),
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w700)),
        Text(val,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B))),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- CLEAN LABEL ---
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              "ACTIONS",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFF94A3B8),
                letterSpacing: 1.5,
              ),
            ),
          ),

          // 1. View Detailed Report
          _buildMinimalBtn(
              "View Detailed Report",
              Icons.analytics_outlined,
              const Color(0xFF1D4ED8),
              () => _navigateTo(PrincipalRoutes.gradesAnalytics,
                  arguments: {'studentData': widget.studentData})),

          const SizedBox(height: 12),

          // 2. View Attendance History
          _buildMinimalBtn(
              "View Attendance History",
              Icons.calendar_today_outlined,
              const Color(0xFF1D4ED8),
              () => _navigateTo(PrincipalRoutes.attendanceAnalytics,
                  arguments: {'studentData': widget.studentData})),

          const SizedBox(height: 12),

          // 3. Quick Contact Parent
          _buildMinimalBtn(
            "Quick Contact Parent",
            Icons.chat_bubble_outline_rounded,
            const Color(0xFF16A34A),
            () => _openParentContactOptions(context),
          ),

          // 4. Critical Meeting (Only if applicable)
          if (_isCritical) ...[
            const SizedBox(height: 12),
            _buildMinimalBtn(
                "Schedule Parent Meeting",
                Icons.notification_important_outlined,
                const Color(0xFFE11D48),
                () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Meeting request sent!'),
                    behavior: SnackBarBehavior.floating))),
          ],
        ],
      ),
    );
  }

  void _openParentContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(
          24,
          20,
          24,
          MediaQuery.of(context).padding.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Contact Parent",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _contactBtn(
                  icon: Icons.call_rounded,
                  label: "Call",
                  color: const Color(0xFF1D4ED8),
                  onTap: () {
                    Navigator.pop(context);
                    _dummyAction(context, "Calling parent...");
                  },
                ),
                _contactBtn(
                  icon: Icons.message_rounded,
                  label: "WhatsApp",
                  color: const Color(0xFF16A34A),
                  onTap: () {
                    Navigator.pop(context);
                    _dummyAction(context, "Opening WhatsApp...");
                  },
                ),
                _contactBtn(
                  icon: Icons.email_rounded,
                  label: "Email",
                  color: const Color(0xFFF59E0B),
                  onTap: () {
                    Navigator.pop(context);
                    _dummyAction(context, "Opening email...");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  void _dummyAction(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

// --- MINIMALIST BUTTON HELPER ---
  Widget _buildMinimalBtn(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // ✨ Ultra-light border only
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 12, color: Color(0xFFCBD5E1)),
            ],
          ),
        ),
      ),
    );
  }

// --- REUSABLE PREMIUM ACTION TILE HELPER ---
  Widget _buildActionTile({
    required String label,
    required IconData icon,
    required Color color,
    required bool isFullWidth,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isFullWidth ? 18 : 20),
        decoration: BoxDecoration(
          color: isFullWidth ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isFullWidth
              ? null
              : Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: isFullWidth
                  ? color.withOpacity(0.3)
                  : Colors.black.withOpacity(0.02),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isFullWidth
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ],
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: Color(0xFF1E293B)),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _btn(String label, Color c, bool primary, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: primary
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor: c,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0),
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w800)))
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                  foregroundColor: c,
                  side: BorderSide(color: c, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w800))),
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return Container(
  //     decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex, onTap: _onBottomNavTap,
  //       type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
  //       selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
  //       elevation: 0, selectedFontSize: 11, unselectedFontSize: 11,
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_rounded),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search_rounded),
  //           label: "Search",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.analytics_rounded),
  //           label: "Activity",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.grid_view_rounded),
  //           label: "More",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Color _getGradeColor(double grade) {
    if (grade < 40) return const Color(0xFFE11D48);
    if (grade < 65) return const Color(0xFFF59E0B);
    return const Color(0xFF1D4ED8);
  }

  Color _getAttendanceColor(double att) {
    if (att < 75) return const Color(0xFFE11D48);
    return const Color(0xFF16A34A);
  }
}

class StudentGradesDetailPage extends StatelessWidget {
  final Map<String, dynamic> studentData;
  const StudentGradesDetailPage({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    // Mock data for exam-wise breakdown
    final List<Map<String, dynamic>> exams = [
      {
        'title': 'Unit Test 1',
        'date': 'Aug 2024',
        'marks': {'Math': 45, 'Science': 38, 'English': 60}
      },
      {
        'title': 'Unit Test 2',
        'date': 'Oct 2024',
        'marks': {'Math': 42, 'Science': 40, 'English': 55}
      },
      {
        'title': 'Quarterly Exam',
        'date': 'Dec 2024',
        'marks': {'Math': 40, 'Science': 35, 'English': 52}
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Academic Breakdown")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ExpansionTile(
              title: Text(exam['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(exam['date']),
              children: (exam['marks'] as Map<String, int>).entries.map((e) {
                return ListTile(
                  title: Text(e.key),
                  trailing: Text("${e.value}/100",
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class StudentAttendanceHistoryPage extends StatelessWidget {
  final Map<String, dynamic> studentData;
  const StudentAttendanceHistoryPage({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance History")),
      body: Column(
        children: [
          // Monthly Summary Card
          _buildSummaryHeader(),
          Expanded(
            child: ListView.separated(
              itemCount: 20, // Sample count
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: index % 5 == 0
                        ? Colors.red.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                    child: Icon(
                      index % 5 == 0 ? Icons.close : Icons.check,
                      color: index % 5 == 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  title: Text("Date: ${20 - index} Dec 2024"),
                  trailing: Text(index % 5 == 0 ? "ABSENT" : "PRESENT",
                      style: TextStyle(
                          color: index % 5 == 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue.shade50,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [
            Text("Total Days"),
            Text("120",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ]),
          Column(children: [
            Text("Present"),
            Text("102",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green))
          ]),
          Column(children: [
            Text("Absent"),
            Text("18",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
          ]),
        ],
      ),
    );
  }
}
