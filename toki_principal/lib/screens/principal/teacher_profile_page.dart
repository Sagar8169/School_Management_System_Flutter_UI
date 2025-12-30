import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';
import 'timetable_page.dart';

class TeacherProfilePage extends StatefulWidget {
  final Map<String, dynamic> teacherData;

  const TeacherProfilePage({super.key, required this.teacherData});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  // int _currentIndex = 1;
  bool _isTelugu = true;

  // --- ORIGINAL DATA ---
  final List<Map<String, dynamic>> _assignedClasses = [
    {
      'className': 'Class 8A',
      'students': 42,
      'avgGrade': 85.0,
      'attendance': 94.0
    },
    {
      'className': 'Class 9B',
      'students': 38,
      'avgGrade': 82.0,
      'attendance': 91.0
    },
  ];

  // --- ORIGINAL FUNCTIONS ---
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ MERGED PREMIUM HEADER (Back + Title + Branding)
            _buildMergedHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20), // Padding after header

                    // ✨ PREMIUM PROFILE CARD
                    _buildPremiumTeacherCard(),

                    const SizedBox(height: 24),

                    // ✨ CONTACT INFORMATION
                    _buildInfoSection("Contact Information",
                        Icons.contact_mail_outlined, _buildContactContent()),

                    const SizedBox(height: 24),

                    // ✨ ASSIGNED CLASSES
                    _buildAssignedClassesSection(),

                    const SizedBox(height: 24),

                    // ✨ PERFORMANCE SUMMARY
                    _buildPerformanceSummary(),

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

  // --- NEW MERGED HEADER COMPONENT ---
  Widget _buildMergedHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.5)),
      ),
      child: Row(
        children: [
          // Back Button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: Color(0xFF1E293B)),
          ),

          const SizedBox(width: 4),

          // Title & School Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Teacher Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A))),
                Text('Aditya International School',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          // Language Switch
          _buildLanguagePill(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildBrandingHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                    color: const Color(0xFF1D4ED8),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text('A',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Faculty Insights',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B))),
                  Text('Aditya International School',
                      style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
          _buildLanguagePill(),
        ],
      ),
    );
  }

  Widget _buildLanguagePill() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20)),
        child: Text(_isTelugu ? 'తెలుగు' : 'English',
            style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.w800,
                fontSize: 11)),
      ),
    );
  }

  Widget _buildCompactSubHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 20, 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: Color(0xFF1E293B)),
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 8),
          const Text('Teachers Profile',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildPremiumTeacherCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFBE481E), Color(0xFFD75B28)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFD75B28).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Text(
                    widget.teacherData['name'][0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.teacherData['name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    Text(widget.teacherData['role'] ?? 'Senior Faculty',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Text("OFFICIAL",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1, color: Colors.white24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCompactInfo(
                  "SUBJECT", widget.teacherData['subject'] ?? 'N/A'),
              _buildCompactInfo(
                  "EXPERIENCE", widget.teacherData['experience'] ?? 'N/A'),
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
                fontSize: 10,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
      ],
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
                  color: const Color(0xFFD75B28).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFD75B28).withOpacity(0.2),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: const Color(0xFFD75B28),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF334155),
                  letterSpacing: 1.1,
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
              borderRadius: BorderRadius.circular(24),

              // 🌟 LIGHT PREMIUM BORDER
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),

              // 🌟 SOFT DEPTH (Optional but premium)
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E293B).withOpacity(0.02),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildContactContent() {
    return Column(children: [
      _dataRow("Official Email", "raghini.sharma@adityaschool.in"),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _dataRow("Phone Number", "+91 98765 43210"),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _dataRow("Employee ID", "TCH-2016-045"),
    ]);
  }

  Widget _buildAssignedClassesSection() {
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
                  color: const Color(0xFFD75B28).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFD75B28).withOpacity(0.2),
                  ),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 16,
                  color: Color(0xFFD75B28),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "ASSIGNED CLASSES",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF334155),
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // --- CLASS CARDS ---
          ..._assignedClasses.map((c) => _buildClassCard(c)),
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        // 🌟 CONSISTENT LIGHT BORDER
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),

        // 🌟 SOFT DEPTH
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- ICON PILL ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFD75B28).withOpacity(0.2),
              ),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Color(0xFFD75B28),
              size: 20,
            ),
          ),

          const SizedBox(width: 14),

          // --- CLASS INFO ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['className'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "${c['students']} Students Enrolled",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // --- AVG GRADE ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${c['avgGrade']}%",
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFD75B28),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "AVG GRADE",
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statBox(
            "98%",
            "Attendance Rate",
            const Color(0xFF16A34A),
          ),
          _statBox(
            "89%",
            "Passing Rate",
            const Color(0xFF1D4ED8),
          ),
        ],
      ),
    );
  }

  Widget _statBox(
    String val,
    String label,
    Color color,
  ) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        // 🌟 Consistent light border
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),

        // 🌟 Soft elevation
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // --- VALUE ---
          Text(
            val,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.6,
            ),
          ),

          const SizedBox(height: 6),

          // --- LABEL ---
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "QUICK ACTIONS",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFF64748B),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),

          // --- 1. VIEW CLASS DETAILS (Direct Navigation) ---
          _buildMainActionBtn(
            "View My Performance",
            Icons.analytics_rounded,
            const Color(0xFF1D4ED8),
            () {
              // Agar aapke paas teacher analytics route hai toh yahan dalo
              Navigator.pushNamed(context, '/teacherPerformance');
            },
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              // --- 2. VIEW TIMETABLE ---
              Expanded(
                child: _buildSecondaryTile(
                  "Timetable",
                  Icons.calendar_today_rounded,
                  const Color(0xFF1D4ED8),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TimetablePage()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              // --- 3. CONTACT TEACHER ---
              Expanded(
                child: _buildSecondaryTile(
                  "Contact",
                  Icons.chat_bubble_outline_rounded,
                  const Color(0xFF10B981),
                  () {
                    // Yahan hum teacher ka naam direct widget se uthayenge
                    // Maan lo aapke widget mein 'name' field hai
                    _showContactOptions(context, "Teacher");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// --- CONTACT OPTIONS OVERLAY (Safe Area Maintain) ---
  void _showContactOptions(BuildContext context, String teacherName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- DRAG HANDLE ---
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 24),

            // --- TITLE ---
            Text(
              "Contact $teacherName",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Choose a preferred contact method",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF94A3B8),
              ),
            ),

            const SizedBox(height: 28),

            // --- ACTION BUTTONS ---
            Row(
              children: [
                Expanded(
                  child: _contactActionCard(
                    icon: Icons.call_rounded,
                    label: "Call",
                    color: const Color(0xFF1D4ED8),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _contactActionCard(
                    icon: Icons.chat_bubble_rounded,
                    label: "Message",
                    color: const Color(0xFF10B981),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E293B).withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactMethod(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 13, color: color)),
        ],
      ),
    );
  }

// --- REUSABLE BUTTON HELPERS ---
  Widget _buildMainActionBtn(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8))
          ],
        ),
        child: Row(
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
        ),
      ),
    );
  }

  Widget _buildSecondaryTile(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Color(0xFF1E293B))),
          ],
        ),
      ),
    );
  }

  Widget _btn(String label, Color color, bool primary) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: primary
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0),
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w800)))
          : OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w800))),
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
}
