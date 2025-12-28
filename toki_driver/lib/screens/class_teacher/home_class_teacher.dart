// lib/screens/class_teacher/home_class_teacher.dart
import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class HomeClassTeacher extends StatefulWidget {
  const HomeClassTeacher({Key? key}) : super(key: key);

  @override
  State<HomeClassTeacher> createState() => _HomeClassTeacherState();
}

class _HomeClassTeacherState extends State<HomeClassTeacher> {
  int _currentIndex = 0;
  String _selectedLanguage = 'తెలుగు';
  bool _showAlert = true;
  bool _attendanceTaken = false;

  final Color _primaryGreen = const Color(0xFF26A675);
  final Color _darkGreenCard = const Color(0xFF1E8D6B);
  final Color _bgGrey = const Color(0xFFF5F6F8);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _textGrey = const Color(0xFF757575);
  final Color _scaffoldBg = const Color(0xFFF5F5F5);
  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _markAttendanceTaken() {
    setState(() {
      _attendanceTaken = true;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    ClassTeacherRoutes.handleBottomNavTap(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 16),
                    if (_showAlert) ...[
                      _buildAlertBanner(),
                      const SizedBox(height: 16),
                    ],
                    _buildGenericCard(
                      onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.attendanceAnalytics),
                      icon: Icons.check_box_outlined,
                      iconColor: const Color(0xFF10B981),
                      iconBg: const Color(0xFFD1FAE5),
                      title: "Today's View",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Today", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD1FAE5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text("93%", style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text("Present: 41 • Absent: 3", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.attendanceAnalytics),
                            child: const Text("View analytics →", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildTakeAttendanceCard(),
                    const SizedBox(height: 12),
                    _buildGenericCard(
                      onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.timetable),
                      icon: Icons.calendar_today,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFEFF6FF),
                      title: "Today's Timetable",
                      child: Column(
                        children: [
                          _buildClassItem("Mathematics", "10:00 AM - 10:45 AM", "Mr. Vijay Prasad", isCurrent: true),
                          const SizedBox(height: 10),
                          _buildClassItem("Science", "10:45 AM - 11:30 AM", "You"),
                          const SizedBox(height: 10),
                          _buildClassItem("English", "11:30 AM - 12:15 PM", "Mrs. Anita Desai"),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.timetable),
                            child: const Text("View full schedule →", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildApprovalsCard(),
                    const SizedBox(height: 12),
                    _buildTasksEventsCard(),
                    const SizedBox(height: 12),
                    _buildMyPerformanceCard(),
                    const SizedBox(height: 12),
                    _buildGenericCard(
                      onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.parentTickets),
                      icon: Icons.chat_bubble_outline,
                      iconColor: const Color(0xFF10B981),
                      iconBg: const Color(0xFFD1FAE5),
                      title: "Parent Tickets",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Open: 3 • Resolved: 12", style: TextStyle(color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.parentTickets),
                            child: const Text("View all tickets →", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: _primaryGreen, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Aditya International School", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("Powered by Toki Tech", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(_selectedLanguage, style: TextStyle(color: _primaryGreen, fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: _primaryGreen, borderRadius: BorderRadius.circular(16)),
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
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
                  child: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Miss Raghini Sharma", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 2),
                    Text("Class Teacher - Class 8B", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: _darkGreenCard, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  _buildInlineStat("44", "Total Students"),
                  const VerticalDivider(color: Colors.white24, thickness: 1, width: 18),
                  _buildInlineStat("93%", "Avg Attendance"),
                  const VerticalDivider(color: Colors.white24, thickness: 1, width: 18),
                  _buildInlineStat("76%", "Avg Grade"),
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
                _buildSmallPill("6", "Total Classes"),
                const SizedBox(width: 10),
                _buildSmallPill("8", "Total Subjects"),
                const SizedBox(width: 10),
                _buildSmallPill("2", "Due Subjects"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), border: const Border(top: BorderSide(color: Colors.white24))),
            child: const Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.white70, size: 14),
                SizedBox(width: 8),
                Text("Saturday, November 9, 2025", style: TextStyle(color: Colors.white, fontSize: 12)),
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
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSmallPill(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
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
                  Text("Cyclone Alert - School Closed", style: TextStyle(color: Color(0xFF7F1D1D), fontWeight: FontWeight.w600)),
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: iconColor, size: 20)),
                    const SizedBox(width: 12),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
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

  Widget _buildTakeAttendanceCard() {
    return _buildGenericCard(
      onTap: _attendanceTaken ? null : () {
        if (!_attendanceTaken) {
          Navigator.pushNamed(context, ClassTeacherRoutes.takeAttendance)
              .then((_) {
            setState(() {
              _attendanceTaken = true;
            });
          });
        }
      },
      icon: Icons.event_available_rounded,
      iconColor: _attendanceTaken ? Colors.grey : const Color(0xFF16A34A),
      iconBg: _attendanceTaken ? Colors.grey.shade200 : const Color(0xFFE6F9ED),
      title: _attendanceTaken ? "Attendance Submitted" : "Take Attendance",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_attendanceTaken ? "Submitted for today" : "Your Class", style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 12),
          if (!_attendanceTaken)
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.takeAttendance),
              child: const Text("Take attendance →", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
            ),
        ],
      ),
    );
  }

  Widget _buildClassItem(String subject, String time, String teacher, {bool isCurrent = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent ? const Color(0xFFE3F2FD).withOpacity(0.5) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: isCurrent ? Border.all(color: const Color(0xFF448AFF)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: isCurrent ? const Color(0xFF448AFF) : Colors.black87)),
              const SizedBox(height: 2),
              Text(teacher, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildApprovalsCard() {
    return _buildGenericCard(
      onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.approvalsList),
      icon: Icons.star_outline_rounded,
      iconColor: const Color(0xFFFFB300),
      iconBg: const Color(0xFFFFFDE7),
      title: "Approvals",
      child: Column(
        children: [
          _buildApprovalItem("Grades", "Mid-term (15 students)", "15", const Color(0xFF4CAF50)),
          const SizedBox(height: 8),
          _buildApprovalItem("Leave", "Pending requests", "4", const Color(0xFFFF9800)),
          const SizedBox(height: 8),
          _buildApprovalItem("Events", "Annual Day preparations", "2", const Color(0xFF2196F3)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.approvalsList),
            child: const Text("Review all →", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalItem(String type, String description, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: color)),
              Text(description, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(count, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksEventsCard() {
    return _buildGenericCard(
      onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.taskAssignment),
      icon: Icons.check_box_outlined,
      iconColor: const Color(0xFF7B1FA2),
      iconBg: const Color(0xFFF3E5F5),
      title: "Tasks & Events",
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Upload Term 1 Grades", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    SizedBox(height: 4),
                    Text("Due: Nov 15, 2025", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(4)),
                  child: const Text("Pending", style: TextStyle(color: Color(0xFFFB8C00), fontSize: 11)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Parent-Teacher Meeting", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    SizedBox(height: 4),
                    Text("Nov 20, 2025 • 2:00 PM", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(4)),
                  child: const Text("Upcoming", style: TextStyle(color: Color(0xFF1976D2), fontSize: 11)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, ClassTeacherRoutes.createNewTask),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Color(0xFF2979FF)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Add Task for Teachers", style: TextStyle(color: Color(0xFF2979FF), fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPerformanceCard() {
    return _buildGenericCard(
      onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.activity),
      icon: Icons.trending_up,
      iconColor: const Color(0xFF7C3AED),
      iconBg: const Color(0xFFEDE9FE),
      title: "My Performance",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Overall Rating", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(12)),
                child: const Text("4.7/5.0", style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Based on 32 parent reviews", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPerformanceMetric("95%", "Attendance Rate"),
              _buildPerformanceMetric("92%", "Grade Avg"),
              _buildPerformanceMetric("4.5", "Communication"),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, ClassTeacherRoutes.activity),
            child: const Text("View details →", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Color(0xFF7C3AED), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home_filled : Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 1 ? Icons.search : Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _currentIndex == 2 ? _selectedPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.show_chart, size: 22),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 3 ? Icons.more_horiz : Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }
}