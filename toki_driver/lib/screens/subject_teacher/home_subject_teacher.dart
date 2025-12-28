import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class HomeSubjectTeacher extends StatefulWidget {
  const HomeSubjectTeacher({Key? key}) : super(key: key);

  @override
  State<HomeSubjectTeacher> createState() => _HomeSubjectTeacherState();
}

class _HomeSubjectTeacherState extends State<HomeSubjectTeacher> {
  int _currentIndex = 0;
  bool _isTelugu = true;
  bool _showAlert = true;

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _darkPurpleCard = const Color(0xFF6D28D9);
  final Color _scaffoldBg = const Color(0xFFF5F5F5);

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isTelugu ? 'తెలుగు భాషలో మార్చబడింది' : 'Switched to English'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          SubjectTeacherRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          SubjectTeacherRoutes.search,
              (route) => false,
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          SubjectTeacherRoutes.activity,
              (route) => false,
        );
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          SubjectTeacherRoutes.settings,
              (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primaryPurple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "ST",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Subject Teacher",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Aditya International School",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 10,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: TextStyle(color: _primaryPurple, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeroSection(),
            const SizedBox(height: 16),
            if (_showAlert) ...[
              _buildAlertBanner(),
              const SizedBox(height: 16),
            ],
            _buildQuickActionsCard(),
            const SizedBox(height: 12),
            _buildGenericCard(
              onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.homework),
              icon: Icons.assignment_outlined,
              iconColor: _primaryPurple,
              iconBg: const Color(0xFFF3E8FF),
              title: "Homework",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "View & Manage",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.homework),
                    child: Text(
                      "View all homework →",
                      style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildGenericCard(
              onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.tasks),
              icon: Icons.task_outlined,
              iconColor: const Color(0xFFFF9800),
              iconBg: const Color(0xFFFFF3E0),
              title: "Tasks",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Assignments & Tasks",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.tasks),
                    child: Text(
                      "View all tasks →",
                      style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildGenericCard(
              onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.schedule),
              icon: Icons.calendar_today,
              iconColor: const Color(0xFF2563EB),
              iconBg: const Color(0xFFEFF6FF),
              title: "Today's Schedule",
              child: Column(
                children: [
                  _buildClassItem("Class 8B • Science", "09:15 AM - 10:00 AM", "Room 201", isCurrent: true),
                  const SizedBox(height: 10),
                  _buildClassItem("Class 9A • Science", "11:00 AM - 11:45 AM", "Room 305"),
                  const SizedBox(height: 10),
                  _buildClassItem("Class 10C • Science", "01:00 PM - 01:45 PM", "Room 402"),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.schedule),
                    child: Text(
                      "View full schedule →",
                      style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildMyPerformanceCard(),
            const SizedBox(height: 12),
            _buildGenericCard(
              onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.attendanceSummary),
              icon: Icons.people_outline,
              iconColor: const Color(0xFF10B981),
              iconBg: const Color(0xFFD1FAE5),
              title: "Attendance Summary",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAttendanceItem("Class 8B", "42/44 Present", "95.5%"),
                  _buildAttendanceItem("Class 9A", "38/42 Present", "90.5%"),
                  _buildAttendanceItem("Class 10C", "44/46 Present", "95.7%"),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Overall Average", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                        Text("93.9%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.attendanceSummary),
                    child: Text(
                      "View analytics →",
                      style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.flash_on, color: _primaryPurple, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  Icons.event_available,
                  "Take Attendance",
                  const Color(0xFF16A34A),
                      () => Navigator.pushNamed(context, SubjectTeacherRoutes.takeAttendance),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  Icons.grading_outlined,
                  "Add Grades",
                  const Color(0xFF2196F3),
                      () => Navigator.pushNamed(context, SubjectTeacherRoutes.uploadGrades),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  Icons.add_circle_outline,
                  "Add Homework",
                  const Color(0xFF9C27B0),
                      () => Navigator.pushNamed(context, SubjectTeacherRoutes.addHomework),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _primaryPurple,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mr. Vijay Prasad",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Science Teacher",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: _darkPurpleCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildInlineStat("3", "Total Classes"),
                  const VerticalDivider(color: Colors.white24, thickness: 1, width: 18),
                  _buildInlineStat("132", "Total Students"),
                  const VerticalDivider(color: Colors.white24, thickness: 1, width: 18),
                  _buildInlineStat("5", "Due Tasks"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallPill("1", "Subjects"),
                const SizedBox(width: 10),
                _buildSmallPill("93%", "Avg Attendance"),
                const SizedBox(width: 10),
                _buildSmallPill("85%", "Avg Grade"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: const Border(top: BorderSide(color: Colors.white24)),
            ),
            child: const Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.white70, size: 14),
                SizedBox(width: 8),
                Text(
                  "Saturday, November 9, 2025",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineStat(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallPill(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Cyclone Alert - School Closed",
                    style: TextStyle(color: Color(0xFF7F1D1D), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _showAlert = false),
                child: const Icon(Icons.close, size: 18, color: Color(0xFF7F1D1D)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Due to severe cyclone warning, school will remain closed on October 21-22, 2025. Stay safe!",
            style: TextStyle(color: Color(0xFF7F1D1D), fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildGenericCard({
    required VoidCallback? onTap,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(String subject, String time, String location, {bool isCurrent = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent ? const Color(0xFFF3E8FF).withOpacity(0.5) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: isCurrent ? Border.all(color: _primaryPurple) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isCurrent ? _primaryPurple : Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                location,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceItem(String className, String detail, String percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(className, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(detail, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(percentage, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPerformanceCard() {
    return _buildGenericCard(
      onTap: () {
        Navigator.pushNamed(
          context,
          SubjectTeacherRoutes.profile,
          arguments: {
            'name': 'Mr. Vijay Prasad',
            'role': 'Science Teacher',
            'employeeId': 'ST2024',
            'department': 'Science',
            'type': 'teacher',
            'isActive': true,
            'assignedClass': '8B, 9A, 10C',
            'subjects': 'Science',
            'phone': '+91 98765 43210',
            'email': 'vijay.prasad@adityaschool.edu',
            'address': '123 Staff Quarters, School Campus',
            'joinDate': 'January 15, 2020',
            'workLocation': 'Main Campus',
          },
        );
      },
      icon: Icons.trending_up,
      iconColor: _primaryPurple,
      iconBg: const Color(0xFFF3E8FF),
      title: "My Performance",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Overall Average",
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "88.5%",
                  style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Based on student performance across all classes",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPerformanceMetric("92%", "Attendance"),
              _buildPerformanceMetric("85%", "Grade Avg"),
              _buildPerformanceMetric("88%", "Completion"),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "View profile for details →",
            style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: _primaryPurple,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: _primaryPurple,
      unselectedItemColor: const Color(0xFF6B7280),
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
          icon: Icon(Icons.show_chart_outlined),
          activeIcon: Icon(Icons.show_chart),
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