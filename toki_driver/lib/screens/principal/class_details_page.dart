import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

class ClassDetailsPage extends StatefulWidget {
  final Map<String, dynamic> classData;

  const ClassDetailsPage({super.key, required this.classData});

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  int _currentIndex = 1;
  bool _isTelugu = true;

  final List<Map<String, dynamic>> _performanceData = [
    {'category': 'Excellent (Above 80%)', 'students': 18, 'color': Color(0xFF4CAF50)},
    {'category': 'Good (60-80%)', 'students': 15, 'color': Color(0xFF2962FF)},
    {'category': 'Average (40-60%)', 'students': 8, 'color': Color(0xFFFFB300)},
    {'category': 'Needs Attention (Below 40%)', 'students': 1, 'color': Color(0xFFE53935)},
  ];

  final List<Map<String, dynamic>> _subjectsData = [
    {'subject': 'Mathematics', 'teacher': 'Miss Raghini Sharma', 'score': 85},
    {'subject': 'Science', 'teacher': 'Mr. Vijay Prasad', 'score': 78},
    {'subject': 'English', 'teacher': 'Mrs. Anita Desai', 'score': 82},
    {'subject': 'Social Studies', 'teacher': 'Mr. Ravi Verma', 'score': 80},
    {'subject': 'Hindi', 'teacher': 'Mrs. Lakshmi Devi', 'score': 84},
  ];

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
          PrincipalRoutes.home,
              (route) => false,
        );
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

  void _showTimetableMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Timetable for ${widget.classData['className']}'),
        backgroundColor: const Color(0xFF10B981),
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
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // Header (Keeping your original header)
            CommonWidgets.appHeader(
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: _toggleLanguage,
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔵 BLUE GRADIENT HEADER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 14, 18, 26),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF2962FF), // top blue
                            Color(0xFF3A6BFF), // bottom blue
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(28),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back Button + Title
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.22),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Class Details",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // 🔵 INNER BLUE CARD
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E45D9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.22),
                                  blurRadius: 15,
                                  offset: const Offset(0, 7),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Rounded class indicator
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF6F8FFF),
                                      ),
                                      child: Text(
                                        classShort,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Class $classShort",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Section ${section.replaceAll('Section ', '')}",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.7),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(.22),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Class Teacher",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  teacher,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),

                    // CLASS OVERVIEW
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "Class Overview",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOverviewStat(
                          value: "42",
                          label: "Students",
                          valueColor: const Color(0xFF2962FF),
                        ),
                        _buildOverviewStat(
                          value: "82%",
                          label: "Avg Grade",
                          valueColor: const Color(0xFFFFB300),
                        ),
                        _buildOverviewStat(
                          value: "94%",
                          label: "Attendance",
                          valueColor: const Color(0xFF00A96E),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // PERFORMANCE ANALYTICS
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "Performance Analytics",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            for (var data in _performanceData)
                              _buildPerformanceRow(
                                color: data['color'] as Color,
                                label: data['category'].toString(),
                                value: "${data['students']} ${data['students'] == 1 ? 'student' : 'students'}",
                                percent: (data['students'] as int) / 42,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),

                    // SUBJECTS & TEACHERS
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "Subjects & Teachers",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (var subject in _subjectsData)
                      _buildSubjectTile(
                        subject: subject['subject'].toString(),
                        teacher: subject['teacher'].toString(),
                        score: "${subject['score']}%",
                      ),

                    const SizedBox(height: 24),

                    // BUTTONS
                    _buildBlueButton(
                      text: "View All Students",
                      onPressed: () {
                        _navigateTo(PrincipalRoutes.studentSearch, arguments: {
                          'classFilter': widget.classData['className'],
                        });
                      },
                    ),
                    _buildWhiteButton(
                      text: "View Timetable",
                      onPressed: _showTimetableMessage,
                    ),
                    _buildWhiteButton(
                      text: "View Attendance and Grades History",
                      onPressed: () {
                        _navigateTo(PrincipalRoutes.attendanceAnalytics, arguments: {
                          'classData': widget.classData,
                        });
                      },
                    ),
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

  Widget _buildOverviewStat({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow({
    required Color color,
    required String label,
    required String value,
    required double percent,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 12, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label, style: const TextStyle(fontSize: 14)),
              ),
              Text(
                value,
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percent,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectTile({
    required String subject,
    required String teacher,
    required String score,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    teacher,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Avg Score",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  score,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlueButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF2962FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhiteButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF2962FF), width: 1.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF2962FF),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
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
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF2962FF),
      unselectedItemColor: const Color(0xFF6B7280),
      selectedLabelStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          activeIcon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }
}