import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class ClassAttendanceDetailPage extends StatefulWidget {
  final Map<String, dynamic> classData;

  const ClassAttendanceDetailPage({Key? key, required this.classData})
      : super(key: key);

  @override
  State<ClassAttendanceDetailPage> createState() =>
      _ClassAttendanceDetailPageState();
}

class _ClassAttendanceDetailPageState extends State<ClassAttendanceDetailPage> {
  bool _isTelugu = false;

  // New Theme Colors
  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _indigoDeep = const Color(0xFF4338CA); // New Deep Indigo
  final Color _indigoLight = const Color(0xFF6366F1); // New Light Indigo
  final Color _bgLight = const Color(0xFFF8FAFC);
  final Color _accentGreen = const Color(0xFF10B981); // For progress bars

  @override
  Widget build(BuildContext context) {
    final String className = widget.classData['className'] ?? "Class 8B";
    final String present = widget.classData['present'] ?? "42";
    final String absent = widget.classData['absent'] ?? "2";
    final String rate = widget.classData['percent'] ?? "95.5%";

    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(className),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIndigoHeroHeader(
                        present, absent, rate), // ✅ New Indigo Gradient Hero
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const Text("WEEKLY PERFORMANCE TREND",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF64748B),
                                  letterSpacing: 1.2)),
                          const SizedBox(height: 12),
                          _buildTrendSection(),
                          const SizedBox(height: 32),
                          _buildActionButtons(),
                          const SizedBox(height: 30),
                        ],
                      ),
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

  // --- 1. HEADER (Synced Style) ---
  Widget _buildExactHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
      ]),
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
          Text("$title Overview",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'ಕನ್ನಡ' : 'English',
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

  // --- 2. HERO HEADER (New Indigo Gradient) ---
  Widget _buildIndigoHeroHeader(String p, String a, String r) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [_indigoDeep, _indigoLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: _indigoDeep.withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 12))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Today's Summary",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900)),
              Icon(Icons.insights_rounded,
                  color: Colors.white.withOpacity(0.5), size: 24),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _heroStatCol(p, "Present"),
                Container(width: 1, height: 35, color: Colors.white24),
                _heroStatCol(a, "Absent"),
                Container(width: 1, height: 35, color: Colors.white24),
                _heroStatCol(r, "Avg. Rate"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroStatCol(String val, String label) {
    return Column(
      children: [
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label.toUpperCase(),
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5)),
      ],
    );
  }

  // --- 3. TREND SECTION ---
  Widget _buildTrendSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      child: Column(
        children: [
          _buildTrendRow("Mon", 0.932, "93.2%"),
          const SizedBox(height: 18),
          _buildTrendRow("Tue", 0.955, "95.5%"),
          const SizedBox(height: 18),
          _buildTrendRow("Wed", 0.909, "90.9%"),
          const SizedBox(height: 18),
          _buildTrendRow("Thu", 0.977, "97.7%"),
          const SizedBox(height: 18),
          _buildTrendRow("Fri", 0.932, "93.2%"),
        ],
      ),
    );
  }

  Widget _buildTrendRow(String day, double value, String label) {
    return Row(
      children: [
        SizedBox(
            width: 45,
            child: Text(day,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF334155)))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
                value: value,
                backgroundColor: const Color(0xFFF1F5F9),
                color: _accentGreen,
                minHeight: 10),
          ),
        ),
        const SizedBox(width: 12),
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Color(0xFF475569))),
      ],
    );
  }

  // --- 4. ACTION BUTTONS ---
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(
                context, SubjectTeacherRoutes.attendanceSummary),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: BorderSide(color: _primaryPurple, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
            ),
            child: Text("History",
                style: TextStyle(
                    color: _primaryPurple,
                    fontWeight: FontWeight.w900,
                    fontSize: 15)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: _primaryPurple.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8))
                ]),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                  context, SubjectTeacherRoutes.takeAttendance),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: _primaryPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text("Take Today",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15)),
            ),
          ),
        ),
      ],
    );
  }
}
