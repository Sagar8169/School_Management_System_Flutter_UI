import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class AttendanceSummaryPage extends StatefulWidget {
  const AttendanceSummaryPage({Key? key}) : super(key: key);

  @override
  State<AttendanceSummaryPage> createState() => _AttendanceSummaryPageState();
}

class _AttendanceSummaryPageState extends State<AttendanceSummaryPage> {
  bool _isTelugu = false;
  int _selectedToggleIndex = 0;

  // Selection Data - Original Values Ke Sath
  final List<Map<String, dynamic>> _todayClasses = [
    {
      "className": "Class 8B",
      "percent": "95.5%",
      "present": "42",
      "absent": "2",
      "total": "44",
      "color": "green"
    },
    {
      "className": "Class 9A",
      "percent": "90.5%",
      "present": "38",
      "absent": "4",
      "total": "42",
      "color": "blue"
    },
    {
      "className": "Class 10C",
      "percent": "95.7%",
      "present": "44",
      "absent": "2",
      "total": "46",
      "color": "green"
    },
  ];

  final List<Map<String, dynamic>> _weekClasses = [
    {
      "className": "Class 8B",
      "percent": "94.2%",
      "present": "208",
      "absent": "12",
      "total": "220",
      "color": "green"
    },
    {
      "className": "Class 9A",
      "percent": "91.0%",
      "present": "190",
      "absent": "20",
      "total": "210",
      "color": "blue"
    },
    {
      "className": "Class 10C",
      "percent": "96.5%",
      "present": "222",
      "absent": "8",
      "total": "230",
      "color": "green"
    },
  ];

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _greenPrimary = const Color(0xFF2DC58C);
  final Color _bgLight = const Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    final currentList =
        _selectedToggleIndex == 0 ? _todayClasses : _weekClasses;
    final averageStr = _selectedToggleIndex == 0 ? "93.9%" : "94.5%";

    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildWeeklyStyleHero(
                        averageStr), // ✅ Styled Like Weekly Schedule
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCustomToggle(),
                          const SizedBox(height: 24),
                          const Text("Detailed Breakdown",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E293B))),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: currentList.length,
                            itemBuilder: (context, index) =>
                                _buildClassItem(currentList[index]),
                          ),
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

  // --- 1. PREMIUM HEADER (Purple Theme) ---
  Widget _buildExactHeader() {
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
          const Text("Attendance Summary",
              style: TextStyle(
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

  // --- 2. HERO HEADER (Styled Like Weekly Schedule Code) ---
// ✅ 2. PREMIUM HERO HEADER (Modern Glassmorphism Style)
  Widget _buildWeeklyStyleHero(String avg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF10B981), const Color(0xFF047857)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Overall Performance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.auto_graph_rounded,
                    color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        value: 0.94,
                        strokeWidth: 6,
                        backgroundColor: Colors.white12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      avg.replaceAll('%', ''),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "AVG. ATTENDANCE",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        avg,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _headerQuickStat(Icons.people_alt_rounded,
                  "${_selectedToggleIndex == 0 ? '132' : '660'} Students"),
              const SizedBox(width: 16),
              _headerQuickStat(Icons.class_rounded, "3 Classes"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerQuickStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white60, size: 14),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
              color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // --- 3. CUSTOM WORKING TOGGLE ---
  Widget _buildCustomToggle() {
    return Container(
      height: 54,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          _toggleBtn("Today", 0),
          _toggleBtn("This Week", 1),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, int index) {
    bool isSelected = _selectedToggleIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedToggleIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isSelected ? _greenPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: _greenPrimary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ]
                : [],
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
        ),
      ),
    );
  }

  // --- 4. CLASS BREAKDOWN CARDS ---
  Widget _buildClassItem(Map<String, dynamic> data) {
    Color badgeColor =
        data['color'] == 'green' ? _greenPrimary : const Color(0xFF448AFF);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, SubjectTeacherRoutes.classAttendance,
          arguments: data),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data['className'],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B))),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(data['percent'],
                      style: TextStyle(
                          color: badgeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(height: 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCol(data['present'], "Present", _greenPrimary),
                _statCol(data['absent'], "Absent", Colors.redAccent),
                _statCol(data['total'], "Total", Colors.grey.shade800),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _statCol(String val, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(val,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: color)),
        Text(label,
            style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 11,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
