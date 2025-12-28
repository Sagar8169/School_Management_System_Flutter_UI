import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int _currentIndex = 2;
  bool _isTelugu = true;

  final List<Map<String, dynamic>> _activityItems = [
    {
      'title': 'Take Attendance',
      'subtitle': 'Monthly Average: 96%',
      'icon': Icons.how_to_reg_rounded,
      'iconBgColor': const Color(0xFFE6F9ED),
      'iconColor': Colors.blue, // Changed to match new UI
      'route': PrincipalRoutes.takeAttendance,
    },
    {
      'title': 'Add Task (Teachers)',
      'subtitle': '12 Pending Tasks',
      'icon': Icons.task_alt_rounded,
      'iconBgColor': const Color(0xFFE0ECFF),
      'iconColor': Colors.orange,
      'route': PrincipalRoutes.pendingApprovals,
    },
    {
      'title': 'Collect Fee',
      'subtitle': 'Monthly Average: 96%',
      'icon': Icons.currency_rupee_rounded,
      'iconBgColor': const Color(0xFFFEF3C7),
      'iconColor': const Color(0xFFD97706),
      'route': null,
    },
    {
      'title': 'Add Event (School)',
      'subtitle': 'Next: Sports Day (Nov 15)',
      'icon': Icons.event_available_rounded,
      'iconBgColor': const Color(0xFFF3E8FF),
      'iconColor': Colors.purple,
      'route': null,
    },
    {
      'title': 'Add Grades',
      'subtitle': 'Unit Exam 2 ongoing',
      'icon': Icons.auto_graph_rounded,
      'iconBgColor': const Color(0xFFFFF1F2),
      'iconColor': Colors.indigo,
      'route': PrincipalRoutes.uploadGrades,
    },
    {
      'title': 'Add Homework',
      'subtitle': 'Daily logs for Class 10',
      'icon': Icons.menu_book_rounded,
      'iconBgColor': const Color(0xFFE0F2FE),
      'iconColor': Colors.pink,
      'route': null,
    },
  ];

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
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
        _navigateTo(PrincipalRoutes.search);
        break;
      case 2:
      // Already on activity page
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

  void _openMoreSection(String sectionKey) {
    Navigator.pushNamed(
      context,
      PrincipalRoutes.morePage,
      arguments: {'section': sectionKey},
    );
  }

  void _handleActivityTap(Map<String, dynamic> item) {
    if (item['route'] != null) {
      _navigateTo(item['route']);
    } else {
      switch (item['title']) {
        case 'Collect Fee':
          _openMoreSection('fee');
          break;
        case 'Add Event (School)':
          _openMoreSection('events');
          break;
        case 'Add Homework':
          _openMoreSection('homework');
          break;
        default:
          _openMoreSection('more');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Main Content
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Activity List with new UI
                      _buildActivityList(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1D4ED8),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Powered by Toki Tech',
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
                  color: Color(0xFF1D4ED8),
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

  Widget _buildActivityList() {
    return Column(
      children: _activityItems.map((item) {
        return _buildActivityItem(
          title: item['title'],
          subtitle: item['subtitle'],
          icon: item['icon'],
          color: item['iconColor'],
          onTap: () => _handleActivityTap(item),
        );
      }).toList(),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E4072),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      selectedItemColor: const Color(0xFF1D4ED8),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_rounded),
          label: 'More',
        ),
      ],
    );
  }
}