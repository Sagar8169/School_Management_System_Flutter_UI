import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class ClassDetailsPage extends StatefulWidget {
  final Map<String, dynamic> classData;

  const ClassDetailsPage({super.key, required this.classData});

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  bool _isTelugu = true;

  // ✅ Theme Colors - Matches your Search Page Purple
  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _darkPurple = const Color(0xFF6D28D9);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);

  final List<Map<String, dynamic>> _performanceData = [
    {
      'category': 'Excellent (Above 80%)',
      'students': 18,
      'color': const Color(0xFF10B981)
    },
    {
      'category': 'Good (60-80%)',
      'students': 15,
      'color': const Color(0xFF3B82F6)
    },
    {
      'category': 'Average (40-60%)',
      'students': 8,
      'color': const Color(0xFFF59E0B)
    },
    {
      'category': 'Needs Attention (Below 40%)',
      'students': 1,
      'color': const Color(0xFFEF4444)
    },
  ];

  final List<Map<String, dynamic>> _subjectsData = [
    {'subject': 'Mathematics', 'teacher': 'Miss Raghini Sharma', 'score': 85},
    {'subject': 'Science', 'teacher': 'Mr. Vijay Prasad', 'score': 78},
    {'subject': 'English', 'teacher': 'Mrs. Anita Desai', 'score': 82},
    {'subject': 'Social Studies', 'teacher': 'Mr. Ravi Verma', 'score': 80},
    {'subject': 'Hindi', 'teacher': 'Mrs. Lakshmi Devi', 'score': 84},
  ];

  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void _showTimetableMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Timetable for ${widget.classData['className'] ?? 'Class'}'),
        backgroundColor: _primaryPurple,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String className =
        widget.classData['className']?.toString() ?? 'Class';
    final String section = widget.classData['section']?.toString() ?? 'A';
    final String teacher =
        widget.classData['teacher']?.toString() ?? 'Not Assigned';
    final String classShort =
        className.contains(' ') ? className.split(' ').last : className;

    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // Purple Header with Back Button
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildHeroDashboard(
                          className, section, teacher, classShort),
                      const SizedBox(height: 16),
                      _buildQuickStats(),
                      const SizedBox(height: 32),
                      _sectionTitle("Performance Analytics"),
                      _buildAnalyticsCard(),
                      const SizedBox(height: 32),
                      _sectionTitle("Subjects & Teachers"),
                      ..._subjectsData.map((s) => _buildModernSubjectTile(s)),
                      const SizedBox(height: 32),
                      _buildOriginalButtons(
                          className), // ✅ Same 3 Buttons from original
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HEADER: PURPLE THEME ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: _primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
              child: Text("Class Details",
                  style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English',
                  style: TextStyle(
                      color: _primaryPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // --- HERO CARD ---
  Widget _buildHeroDashboard(
      String name, String sec, String teacher, String short) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [_primaryPurple, _darkPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: _primaryPurple.withOpacity(0.3),
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
                child: Center(
                    child: Text(short,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text("Section ${sec.replaceAll('Section ', '')}",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.person_pin_rounded,
                  color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text("Class Teacher: ",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 14)),
              Text(teacher,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statBox("42", "Students", _primaryPurple),
        _statBox("82%", "Avg Grade", Colors.orange),
        _statBox("94%", "Attendance", Colors.green),
      ],
    );
  }

  Widget _statBox(String v, String l, Color c) => Container(
        width: (MediaQuery.of(context).size.width - 48) / 3,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withOpacity(0.03))),
        child: Column(
          children: [
            Text(v,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w900, color: c)),
            Text(l,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget _buildAnalyticsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.black.withOpacity(0.03))),
      child: Column(
        children: _performanceData.map((data) {
          double percent = (data['students'] as int) / 42;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['category'],
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF334155))),
                    Text("${data['students']} students",
                        style: TextStyle(
                            color: data['color'],
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                      value: percent,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: AlwaysStoppedAnimation<Color>(data['color']),
                      minHeight: 8),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernSubjectTile(Map s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.black.withOpacity(0.02))),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['subject'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1E293B))),
              Text(s['teacher'],
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Avg Score",
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text("${s['score']}%",
                  style: TextStyle(
                      color: _primaryPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  // --- ✅ ORIGINAL BUTTON NAMES (3 BUTTONS ONLY) ---
  Widget _buildOriginalButtons(String className) {
    return Column(
      children: [
        _btn("View All Students", Icons.people_alt_outlined, _primaryPurple,
            true, () {
          _navigateTo(SubjectTeacherRoutes.studentSearch,
              arguments: {'classFilter': className});
        }),
        const SizedBox(height: 12),
        _btn("View Timetable", Icons.calendar_today_rounded, _primaryPurple,
            false, () => _showTimetableMessage()),
        const SizedBox(height: 12),
        _btn("View Attendance and Grades History", Icons.history_rounded,
            _primaryPurple, false, () {
          _navigateTo(SubjectTeacherRoutes.attendanceAnalytics,
              arguments: {'classData': widget.classData});
        }),
      ],
    );
  }

  Widget _btn(String t, IconData i, Color c, bool fill, VoidCallback onTap) =>
      SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(i, size: 20),
          label: Text(t),
          style: ElevatedButton.styleFrom(
            backgroundColor: fill ? c : Colors.white,
            foregroundColor: fill ? Colors.white : c,
            elevation: 0,
            side: fill ? null : BorderSide(color: c.withOpacity(0.4)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      );

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 4),
        child: Text(title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E293B))),
      );
}
