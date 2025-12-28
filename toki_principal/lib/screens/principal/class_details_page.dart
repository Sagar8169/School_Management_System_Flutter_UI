import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';
import 'timetable_page.dart';

class ClassDetailsPage extends StatefulWidget {
  final Map<String, dynamic> classData;

  const ClassDetailsPage({super.key, required this.classData});

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  int _currentIndex = 1;
  bool _isTelugu = true;

  // --- ORIGINAL DATA LISTS (Unchanged) ---
  final List<Map<String, dynamic>> _performanceData = [
    {'category': 'Excellent (Above 80%)', 'students': 18, 'color': const Color(0xFF10B981)},
    {'category': 'Good (60-80%)', 'students': 15, 'color': const Color(0xFF3B82F6)},
    {'category': 'Average (40-60%)', 'students': 8, 'color': const Color(0xFFF59E0B)},
    {'category': 'Needs Attention', 'students': 1, 'color': const Color(0xFFEF4444)},
  ];

  final List<Map<String, dynamic>> _subjectsData = [
    {'subject': 'Mathematics', 'teacher': 'Miss Raghini Sharma', 'score': 85},
    {'subject': 'Science', 'teacher': 'Mr. Vijay Prasad', 'score': 78},
    {'subject': 'English', 'teacher': 'Mrs. Anita Desai', 'score': 82},
    {'subject': 'Social Studies', 'teacher': 'Mr. Ravi Verma', 'score': 80},
    {'subject': 'Hindi', 'teacher': 'Mrs. Lakshmi Devi', 'score': 84},
  ];

  // --- ORIGINAL FUNCTIONS (Unchanged Logic) ---
  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
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


  void _showTimetableMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Timetable for ${widget.classData['className']}'),
        backgroundColor: const Color(0xFF1D4ED8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String className = widget.classData['className']?.toString() ?? 'Class';
    final String section = widget.classData['section']?.toString() ?? 'Section A';
    final String teacher = widget.classData['teacher']?.toString() ?? 'Not Assigned';
    final String classShort = className.split(' ').last;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ PREMIUM HEADER (Screenshot Style)
            _buildPremiumHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔵 ULTRA-PREMIUM BLUE CARD
                    _buildPremiumClassCard(classShort, section, teacher),

                    const SizedBox(height: 10),

                    // ✨ CLASS OVERVIEW STATS
                    _buildSectionHeader("Academic Overview"),
                    const SizedBox(height: 15),
                    _buildStatsRow(),

                    const SizedBox(height: 30),

                    // ✨ PERFORMANCE ANALYTICS CARD
                    _buildSectionHeader("Performance Analytics"),
                    const SizedBox(height: 15),
                    _buildPerformanceCard(),

                    const SizedBox(height: 30),

                    // ✨ SUBJECT TILES
                    _buildSectionHeader("Subjects & Faculty"),
                    const SizedBox(height: 15),
                    ..._subjectsData.map((s) => _buildSubjectTile(
                      subject: s['subject'],
                      teacher: s['teacher'],
                      score: "${s['score']}%",
                    )),

                    const SizedBox(height: 30),

                    // ✨ MODERN ACTION BUTTONS
                    _buildActionButtons(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildPremiumHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF1E293B)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Class Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                Text('Aditya International School', style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
              ],
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(20)),
        child: Text(_isTelugu ? 'తెలుగు' : 'English', style: const TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.w800, fontSize: 12)),
      ),
    );
  }

  Widget _buildPremiumClassCard(String name, String sec, String teacher) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: const Color(0xFF1D4ED8).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.2))),
                child: Center(child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900))),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Class $name", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                  Text(sec, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Colors.white24, height: 1)),
          Row(
            children: [
              const Icon(Icons.verified_user_rounded, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text("Primary In-charge: ", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
              Expanded(child: Text(teacher, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Vertical Accent Bar
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D4ED8), // Theme Primary Color
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Main Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statBox("42", "Students", const Color(0xFF1D4ED8), Icons.people_outline),
          _statBox("82%", "Avg Grade", const Color(0xFFF59E0B), Icons.auto_graph),
          _statBox("94%", "Attendance", const Color(0xFF10B981), Icons.done_all),
        ],
      ),
    );
  }

  Widget _statBox(String val, String label, Color color, IconData icon) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 3,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: color.withOpacity(0.6)),
          const SizedBox(height: 8),
          Text(val, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        // --- SUBTLE BORDER ---
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Performance Insights",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1E293B)),
              ),
              Icon(Icons.insights_rounded, size: 20, color: Colors.grey.shade400),
            ],
          ),
          const SizedBox(height: 24),

          // Data Rows
          ..._performanceData.map((data) {
            double percent = (data['students'] as int) / 42;
            return _buildModernPerformanceRow(
              color: data['color'] as Color,
              label: data['category'].toString(),
              count: data['students'].toString(),
              percent: percent,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildModernPerformanceRow({
    required Color color,
    required String label,
    required String count,
    required double percent,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF475569)),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: count,
                      style: TextStyle(fontWeight: FontWeight.w900, color: color, fontSize: 14),
                    ),
                    TextSpan(
                      text: " Students",
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Custom Progress Bar
          Stack(
            children: [
              // Background Track
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Animated Progress
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOutCubic,
                height: 8,
                width: (MediaQuery.of(context).size.width - 80) * percent,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildPerformanceRow({required Color color, required String label, required String value, required double percent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
              Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
              value: percent,
              backgroundColor: const Color(0xFFF1F5F9),
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(12)
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectTile({required String subject, required String teacher, required String score}) {
    // Score ke basis par color decide karne ka logic (Optional)
    final double scoreVal = double.tryParse(score.replaceAll('%', '')) ?? 0;
    final Color scoreColor = scoreVal >= 80 ? const Color(0xFF0D9488) : const Color(0xFF1D4ED8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // --- PREMIUM LIGHT BORDER ---
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Subject Leading Icon with dynamic initial
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scoreColor.withOpacity(0.15), scoreColor.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                subject[0].toUpperCase(), // Pehla letter
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Subject & Teacher Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.person_outline_rounded, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      teacher,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Score Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: scoreColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scoreColor.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                Text(
                  score,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: scoreColor,
                  ),
                ),
                Text(
                  "Avg",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    color: scoreColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 16),
            child: Text(
              "Quick Actions",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF64748B)),
            ),
          ),
          Row(
            children: [
              // View Students (Primary Action)
              _buildActionCard(
                "Students",
                Icons.groups_rounded,
                const Color(0xFF1D4ED8),
                true,
                    () => _navigateTo(PrincipalRoutes.studentSearch, arguments: {'classFilter': widget.classData['className']}),
              ),
              const SizedBox(width: 12),
              // Timetable
              // Timetable Action Card
              _buildActionCard(
                "Timetable",
                Icons.calendar_month_rounded,
                const Color(0xFF1D4ED8),
                false,
                    () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimetablePage())
                ),
              ),
              const SizedBox(width: 12),
              // Attendance
              _buildActionCard(
                "History",
                Icons.analytics_rounded,
                const Color(0xFF1D4ED8),
                false,
                    () => _navigateTo(PrincipalRoutes.attendanceAnalytics, arguments: {'classData': widget.classData}),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Helper: Modern Action Card
  Widget _buildActionCard(String label, IconData icon, Color color, bool isPrimary, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isPrimary ? color : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPrimary ? Colors.transparent : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isPrimary ? color.withOpacity(0.2) : Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                  icon,
                  color: isPrimary ? Colors.white : color,
                  size: 22
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: isPrimary ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _btn(String text, IconData icon, Color color, bool primary, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity, height: 60,
      child: primary
          ? ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 20),
          label: Text(text, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 0)
      )
          : OutlinedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 20),
          label: Text(text, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          style: OutlinedButton.styleFrom(foregroundColor: color, side: BorderSide(color: color, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex, onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0, selectedFontSize: 11, unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "More",
          ),
        ],
      ),
    );
  }
}