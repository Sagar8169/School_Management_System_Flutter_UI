import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool _isTelugu = true;

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _darkPurple = const Color(0xFF6D28D9);
  final Color _bgLight = const Color(0xFFF8FAFC);

  final List<Map<String, dynamic>> _activityItems = [
    {
      'icon': Icons.fact_check_rounded,
      'title': 'Take Attendance',
      'subtitle': 'Current Avg: 96%',
      'color': const Color(0xFF6366F1),
      'route': SubjectTeacherRoutes.takeAttendance,
    },
    {
      'icon': Icons.auto_awesome_motion_rounded,
      'title': 'Add Grades',
      'subtitle': 'Exam & Test Scores',
      'color': const Color(0xFFEC4899),
      'route': SubjectTeacherRoutes.uploadGrades,
    },
    {
      'icon': Icons.menu_book_rounded,
      'title': 'Add Homework',
      'subtitle': 'Assign to Classes',
      'color': const Color(0xFF8B5CF6),
      'route': SubjectTeacherRoutes.addHomework,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _sectionTitle("Quick Actions"),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: _activityItems.length,
                      itemBuilder: (context, index) =>
                          _buildActionCard(_activityItems[index]),
                    ),
                    const SizedBox(height: 32),
                    _sectionTitle("Recent Logs"),
                    const SizedBox(height: 16),
                    _buildRecentActivitySection(),
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

  // --- HEADER: EXACTLY LIKE SEARCH PAGE EXAMPLE ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
              color: Color(0xFFF1F5F9), width: 1), // Subtle separator line
        ),
      ),
      child: Row(
        children: [
          // ST Logo Square (Consistent with Search Page)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _primaryPurple, // Color(0xFF7C3AED)
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
          const SizedBox(width: 12),
          // School Info
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subject Teacher",
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Aditya International School",
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Language Toggle (English/Kannada)
          GestureDetector(
            onTap: () {
              setState(() {
                _isTelugu = !_isTelugu; // Using your existing boolean logic
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'ಕನ್ನಡ' : 'English',
                style: TextStyle(
                  color: _primaryPurple,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: item['color'].withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, item['route']),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: item['color'].withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Icon(item['icon'], color: item['color'], size: 28),
                ),
                const SizedBox(height: 12),
                Text(item['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                Text(item['subtitle'],
                    style: TextStyle(
                        color: item['color'].withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    final List<Map<String, dynamic>> logs = [
      {
        'time': '10:30 AM',
        'action': 'Class 8B Attendance',
        'status': 'Done',
        'color': Colors.green
      },
      {
        'time': 'Yesterday',
        'action': 'Math Test Grades',
        'status': 'Done',
        'color': Colors.green
      },
      {
        'time': '2 days ago',
        'action': 'Class 8A Homework',
        'status': 'Pending',
        'color': Colors.orange
      },
    ];

    return Column(
      children: logs
          .map((log) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.03)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: log['color'].withOpacity(0.1),
                      child: Icon(
                          log['status'] == 'Done'
                              ? Icons.check_rounded
                              : Icons.access_time_rounded,
                          color: log['color'],
                          size: 18),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(log['action'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF334155))),
                          Text(log['time'],
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFF94A3B8))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: log['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(log['status'],
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: log['color'])),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            letterSpacing: -0.5));
  }
}
