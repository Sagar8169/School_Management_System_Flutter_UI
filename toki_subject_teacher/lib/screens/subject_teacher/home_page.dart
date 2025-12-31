import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isTelugu = true;
  bool _showAlert = true;

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _darkPurpleCard = const Color(0xFF6D28D9);
  final Color _scaffoldBg = const Color(0xFFF1F5F9);
  final Color _textPrimary = const Color(0xFF1E293B);
  final Color _textSecondary = const Color(0xFF64748B);

  void _toggleLanguage() {
    setState(() => _isTelugu = !_isTelugu);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isTelugu ? 'తెలుగు భాషలో మార్చబడింది' : 'Switched to English'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(child: _buildHomeworkCard()),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTasksCard()),
                      ],
                    ),
                    const SizedBox(height: 12),

                    _buildScheduleCard(),
                    const SizedBox(height: 12),

                    _buildAttendanceSummaryCard(), // ✅ Ab ye upar hai
                    const SizedBox(height: 12),

                    _buildMyPerformanceCard(), // ✅ Ab ye niche hai
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: _primaryPurple, borderRadius: BorderRadius.circular(8)),
            child: const Center(
                child: Text("ST",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14))),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subject Teacher",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Text("Aditya International School",
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
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

  // --- CHANGED: IMPROVED HERO SECTION ---
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primaryPurple, _darkPurpleCard],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: _primaryPurple.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
                radius: 50, backgroundColor: Colors.white.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFFEDE9FE),
                          child: Icon(Icons.person,
                              color: Color(0xFF7C3AED), size: 30)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Mr. Vijay Prasad",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          const SizedBox(height: 2),
                          const Text("Science Teacher",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.school,
                                  color: Colors.white60, size: 12),
                              const SizedBox(width: 4),
                              Text("Aditya International School",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      _inlineStat("3", "Classes"),
                      Container(width: 1, height: 20, color: Colors.white24),
                      _inlineStat("132", "Students"),
                      Container(width: 1, height: 20, color: Colors.white24),
                      _inlineStat("5", "Due Tasks"),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text("Saturday, November 9, 2025",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 11,
                        letterSpacing: 0.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- CHANGED: BOX STYLE FOR HOMEWORK & TASKS ---
  Widget _buildHomeworkCard() => _buildCompactFeatureCard(
        onTap: () =>
            Navigator.pushNamed(context, SubjectTeacherRoutes.homework),
        icon: Icons.assignment_outlined,
        color: _primaryPurple,
        title: "Homework",
        subtitle: "4 Pending",
      );

  Widget _buildTasksCard() => _buildCompactFeatureCard(
        onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.tasks),
        icon: Icons.task_alt_rounded,
        color: const Color(0xFFFF9800),
        title: "Tasks",
        subtitle: "2 New",
      );

  Widget _buildCompactFeatureCard(
      {required VoidCallback onTap,
      required IconData icon,
      required Color color,
      required String title,
      required String subtitle}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1E293B))),
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(
                    color: color, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // --- REST OF THE CODE REMAINS THE SAME ---

  Widget _buildQuickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          const Row(children: [
            Icon(Icons.flash_on, color: Colors.orange, size: 20),
            SizedBox(width: 12),
            Text("Quick Actions",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15))
          ]),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                  child: _actionBtn(
                      Icons.event_available,
                      "Take Attendance",
                      const Color(0xFF16A34A),
                      () => Navigator.pushNamed(
                          context, SubjectTeacherRoutes.takeAttendance))),
              const SizedBox(width: 10),
              Expanded(
                  child: _actionBtn(
                      Icons.grading_outlined,
                      "Add Grades",
                      const Color(0xFF2196F3),
                      () => Navigator.pushNamed(
                          context, SubjectTeacherRoutes.uploadGrades))),
              const SizedBox(width: 10),
              Expanded(
                  child: _actionBtn(
                      Icons.add_circle_outline,
                      "Add Homework",
                      const Color(0xFF9C27B0),
                      () => Navigator.pushNamed(
                          context, SubjectTeacherRoutes.addHomework))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.2))),
        child: Column(children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 10))
        ]),
      ),
    );
  }

  Widget _buildScheduleCard() => _buildGenericCard(
      onTap: () => Navigator.pushNamed(context, SubjectTeacherRoutes.schedule),
      icon: Icons.calendar_today,
      iconColor: const Color(0xFF2563EB),
      iconBg: const Color(0xFFEFF6FF),
      title: "Today's Schedule",
      child: Column(children: [
        _buildClassItem("Class 8B • Science", "09:15 AM - 10:00 AM", "Room 201",
            isCurrent: true),
        const SizedBox(height: 10),
        _buildClassItem(
            "Class 9A • Science", "11:00 AM - 11:45 AM", "Room 305"),
        const SizedBox(height: 12),
        Text("View full schedule →",
            style: TextStyle(
                color: _primaryPurple,
                fontWeight: FontWeight.w600,
                fontSize: 13)),
      ]));

  Widget _buildMyPerformanceCard() {
    return _buildGenericCard(
      onTap: () {
        Navigator.pushNamed(context, SubjectTeacherRoutes.profile, arguments: {
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
        });
      },
      icon: Icons.trending_up,
      iconColor: _primaryPurple,
      iconBg: const Color(0xFFF3E8FF),
      title: "My Performance",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _pStat("92%", "Attendance"),
              _pStat("85%", "Grade Avg"),
              _pStat("88%", "Tasks")
            ],
          ),
          const SizedBox(height: 12),
          Text("View details →",
              style: TextStyle(
                  color: _primaryPurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummaryCard() => _buildGenericCard(
      onTap: () =>
          Navigator.pushNamed(context, SubjectTeacherRoutes.attendanceSummary),
      icon: Icons.people_outline,
      iconColor: const Color(0xFF10B981),
      iconBg: const Color(0xFFD1FAE5),
      title: "Attendance Summary",
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildAttendanceItem("Class 8B", "42/44 Present", "95.5%"),
        _buildAttendanceItem("Class 9A", "38/42 Present", "90.5%"),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Overall Average",
              style: TextStyle(fontWeight: FontWeight.w500)),
          Text("93.9%",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  fontSize: 18)),
        ]),
        const SizedBox(height: 12),
        Text("View analytics →",
            style: TextStyle(
                color: _primaryPurple,
                fontWeight: FontWeight.w600,
                fontSize: 13)),
      ]));

  Widget _inlineStat(String v, String l) => Expanded(
          child: Column(children: [
        Text(v,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        Text(l, style: const TextStyle(color: Colors.white70, fontSize: 10))
      ]));

  Widget _buildAlertBanner() => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFECACA))),
      child: Row(children: [
        const Icon(Icons.warning_amber_rounded,
            color: Color(0xFFDC2626), size: 20),
        const SizedBox(width: 12),
        const Expanded(
            child: Text("School closed on Oct 21-22 due to cyclone.",
                style: TextStyle(
                    color: Color(0xFF7F1D1D), fontWeight: FontWeight.w600))),
        IconButton(
            onPressed: () => setState(() => _showAlert = false),
            icon: const Icon(Icons.close, size: 18))
      ]));

  Widget _buildGenericCard(
      {required VoidCallback? onTap,
      required IconData icon,
      required Color iconColor,
      required Color iconBg,
      required String title,
      required Widget child}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200)),
        child: Column(children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: iconBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: iconColor, size: 20)),
            const SizedBox(width: 12),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20)
          ]),
          const Divider(height: 24),
          child,
        ]),
      ),
    );
  }

  Widget _buildClassItem(String s, String t, String l,
          {bool isCurrent = false}) =>
      Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: isCurrent
                  ? _primaryPurple.withOpacity(0.05)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(8)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? _primaryPurple : Colors.black87)),
              Text(l, style: const TextStyle(color: Colors.grey, fontSize: 11))
            ]),
            Text(t, style: const TextStyle(color: Colors.grey, fontSize: 11))
          ]));

  Widget _buildAttendanceItem(String c, String d, String p) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(c, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(d, style: const TextStyle(color: Colors.grey, fontSize: 11))
        ]),
        Text(p,
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold))
      ]));

  Widget _pStat(String v, String l) => Column(children: [
        Text(v,
            style: TextStyle(
                color: _primaryPurple,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        Text(l, style: const TextStyle(color: Colors.grey, fontSize: 10))
      ]);
}
