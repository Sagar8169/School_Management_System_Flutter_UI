import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class StudentProfilePage extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const StudentProfilePage({super.key, required this.studentData});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  int _currentIndex = 1;
  bool _isTelugu = true;

  final List<Map<String, dynamic>> _subjectsPerformance = [
    {'subject': 'Mathematics', 'score': 42, 'status': 'Critical'},
    {'subject': 'Science', 'score': 38, 'status': 'Critical'},
    {'subject': 'English', 'score': 55, 'status': 'Average'},
    {'subject': 'Hindi', 'score': 62, 'status': 'Good'},
    {'subject': 'Social Studies', 'score': 48, 'status': 'Critical'},
  ];

  bool get _isCritical => widget.studentData['isCritical'] as bool;
  Color get _themeColor => const Color(0xFF7C3AED); // Subject teacher purple

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

  void _onBottomNavTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          SubjectTeacherRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        Navigator.pushNamed(context, SubjectTeacherRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, SubjectTeacherRoutes.activity);
        break;
      case 3:
        Navigator.pushNamed(context, SubjectTeacherRoutes.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // Top Header with navigation
            _buildSubjectTeacherHeader(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(context),
                    const SizedBox(height: 18),

                    _buildAcademicPerformanceCard(),
                    const SizedBox(height: 22),

                    _buildSubjectPerformanceList(),
                    const SizedBox(height: 22),

                    _buildParentInformation(),
                    const SizedBox(height: 22),

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

  Widget _buildSubjectTeacherHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subject Teacher',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  color: Color(0xFF7C3AED),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF9570FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Student Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Inner card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.studentData['name'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.studentData['grade']?.toString() ?? 'Not Specified',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _isCritical ? 'Critical' : 'Good',
                        style: TextStyle(
                          color: _isCritical ? Colors.red[50] : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfo("Student ID", widget.studentData['id']?.toString() ?? 'N/A'),
                    _buildInfo("Class", widget.studentData['grade']?.toString() ?? 'N/A'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAcademicPerformanceCard() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: [
              const Text(
                "Academic Performance",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(
                    '${widget.studentData['avgGrade']}%',
                    "Average Grade",
                    _isCritical ? const Color(0xFFDC2626) : const Color(0xFF2FAE6C),
                  ),
                  _buildStat(
                    '${widget.studentData['attendance']}%',
                    "Attendance",
                    const Color(0xFFE67E22),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_isCritical)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEAEA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Requires Attention\nStudent performance is extremely below average.",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
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

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSubjectPerformanceList() {
    final List<Map<String, dynamic>> subjects = _subjectsPerformance.map((subject) {
      final Color subjectColor = _getGradeColor(subject['score'].toDouble());
      return {
        "name": subject['subject'],
        "status": subject['status'],
        "color": subjectColor,
        "value": "${subject['score']}%"
      };
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Subject-wise Performance",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          for (var subject in subjects) _buildSubjectRow(subject),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(Map<String, dynamic> subject) {
    Color color = subject["color"];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject["name"]!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  subject["status"]!,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subject["value"]!,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Parent Information",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildParentRow(Icons.person, "Parent Name", "Mr. Suresh Singh"),
                const SizedBox(height: 12),
                _buildParentRow(Icons.phone, "Phone Number", "+91 98765 43210"),
                const SizedBox(height: 12),
                _buildParentRow(Icons.calendar_month, "Date of Birth", "March 15, 2010"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentRow(IconData icon, String title, String value) {
    Color bg;
    Color iconColor;

    if (icon == Icons.person) {
      bg = const Color(0xFFEAF2FF);
      iconColor = const Color(0xFF2962FF);
    } else if (icon == Icons.phone) {
      bg = const Color(0xFFE8FFF2);
      iconColor = const Color(0xFF2ECC71);
    } else {
      bg = const Color(0xFFFFF1E5);
      iconColor = const Color(0xFFE67E22);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildPrimaryButton("View Full Report", () {
          // Add navigation or functionality
        }),
        const SizedBox(height: 12),
        _buildOutlineButton("View Attendance History", () {
          // Add navigation or functionality
        }),
        const SizedBox(height: 12),
        _buildOutlineButton("Contact Parent", () {
          // Add contact parent functionality here
        }),
        if (_isCritical) ...[
          const SizedBox(height: 12),
          _buildDangerButton("Schedule Parent Meeting", () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Schedule meeting for ${widget.studentData['name']}'),
                backgroundColor: Colors.green,
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return _buildButtonBase(
      text,
      onPressed,
      bg: const Color(0xFF7C3AED),
      textColor: Colors.white,
    );
  }

  Widget _buildOutlineButton(String text, VoidCallback onPressed) {
    return _buildButtonBase(
      text,
      onPressed,
      border: const Color(0xFF7C3AED),
      textColor: const Color(0xFF7C3AED),
    );
  }

  Widget _buildDangerButton(String text, VoidCallback onPressed) {
    return _buildButtonBase(
      text,
      onPressed,
      bg: const Color(0xFFDD4F43),
      textColor: Colors.white,
    );
  }

  Widget _buildButtonBase(
      String text,
      VoidCallback onPressed, {
        Color? bg,
        Color? textColor,
        Color? border,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            side: border != null ? BorderSide(color: border) : null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      selectedItemColor: const Color(0xFF7C3AED),
      unselectedItemColor: const Color(0xFF6B7280),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          label: 'More',
        ),
      ],
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < 40) return const Color(0xFFDC2626);
    if (grade < 60) return const Color(0xFFD97706);
    if (grade < 80) return const Color(0xFF2563EB);
    return const Color(0xFF16A34A);
  }
}